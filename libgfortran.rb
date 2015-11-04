require 'formula'
require 'find'

# Ironically, we have to require ourselves to use fixup_libgfortran within ourselves
require "#{File.dirname(__FILE__)}/libgfortran"

class Libgfortran < Formula
  homepage 'http://gcc.gnu.org/wiki/GFortran'
  url 'https://github.com/staticfloat/homebrew-libgfortran-formula/archive/master.tar.gz'
  sha1 '09328c065c42051fab341e660837704a3b1f5d4a'
  version '5.2'

  bottle do
    root_url 'https://juliabottles.s3.amazonaws.com'
    cellar :any
    sha256 "655df1ac79b0e63346ed97f333cc667ad6760d490f932412735e2bd516cc1563" => :mountain_lion
    sha256 "4322096e295687709c992904248bace14d4b89d0774c7f97bb402b3d8a10ef60" => :mavericks
    sha256 "0a54c14b84c33d4249df4ab2f139c81d6d5a85fd2e449ab1c97ee759382397c4" => :yosemite
    sha256 "ce6336a6e26df4764b220a7ffaca82b7fcae2d9dd305167f80dd59201e775401" => :el_capitan
  end

  depends_on 'gcc' => :build

  def install
    # To generate a libgfortran installation, steal libraries from gcc!
    mkdir_p lib
    gcc = Formula['gcc']
    for f in ['quadmath.0', 'gcc_s.1', 'gfortran.3']
      system 'cp', "#{gcc.lib}/gcc/#{gcc.version_suffix}/lib#{f}.dylib", lib
    end

    # Create symlinks to non-versioned library versions
    ln_s "libgfortran.3.dylib", "#{lib}/libgfortran.dylib"
    ln_s "libgcc_s.1.dylib", "#{lib}/libgcc_s.dylib"
    ln_s "libquadmath.0.dylib", "#{lib}/libquadmath.dylib"

    fixup_libgfortran(prefix)
  end
end

def pkgconfig_files(keg)
  pkgconfig_files = []

  # find .pc files, which are stored in lib/pkgconfig
  pc_dir = keg.join('lib/pkgconfig')
  if pc_dir.directory?
    pc_dir.find do |pn|
      next if pn.symlink? or pn.directory? or pn.extname.to_s != '.pc'
      pkgconfig_files << pn
    end
  end

  # find name-config scripts, which can be all over the keg
  keg.find do |pn|
    next if pn.symlink? or pn.directory?
    pkgconfig_files << pn if pn.text_executable? and pn.basename.to_s.end_with? '-config'
  end
  pkgconfig_files
end


# Here, we're going to find all dylibs and install_name_tool them for libgfortran instead of gcc
# We're also going to modify paths found in .pc files
def fixup_libgfortran(prefix)
  keg = Keg.for(prefix)
  libgfortran = Formula.factory("libgfortran")

  # For each dylib/executable within this keg
  keg.mach_o_files.each do |file|
    # Make sure it's writable
    file.ensure_writable do
      # Search its dependent dylibs
      keg.each_install_name_for(file) do |bad_name|
        # If we find a quadmath, gcc, or gfortran,
        for f in ['quadmath.0', 'gcc_s.1', 'gfortran.3']
          if bad_name =~ /.*#{f}\.dylib/
            # Rename the dependency!
            good_name = libgfortran.opt_lib + Pathname.new(bad_name).basename
            keg.change_install_name(bad_name, good_name, file)
          end
        end
      end
    end
  end

  gcc = Formula.factory("gcc")
  # For each .pc file within this keg
  pkgconfig_files(keg).each do |file|
    # Make sure it's writable
    file.ensure_writable do
      begin
        inreplace file do |s|
          s.gsub! /#{gcc.lib}\/[^ ]*/, "#{libgfortran.opt_lib}"
        end
      rescue
      end
    end
  end
end
