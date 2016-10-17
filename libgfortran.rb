require 'formula'
require 'find'

# Ironically, we have to require ourselves to use fixup_libgfortran within ourselves
require "#{File.dirname(__FILE__)}/libgfortran"

class Libgfortran < Formula
  homepage 'http://gcc.gnu.org/wiki/GFortran'
  url 'https://github.com/staticfloat/homebrew-libgfortran-formula/archive/master.tar.gz'
  sha256 'daa3d315c20d39504e94318254968d97f9de6096900de00ea0dc40bb541154b4'
  version '6.2'

  bottle do
    root_url 'https://juliabottles.s3.amazonaws.com'
    cellar :any
    sha256 "ab951259958a865904c7cb1faa7692fee6c36e29881f8be94134bd053a096ff9" => :mavericks
    sha256 "dfaea5ed4ed027cf39a031bcb0dc314df98c54131fa38fdc814dd6afce65f525" => :yosemite
    sha256 "93e623b2422c656ae65b7074fd53688ac5881b66040cdd7188c044f0ca9f7657" => :el_capitan
    sha256 "b43adce8de1cce59fe4a13767d036bf5c57d0b51e0909db471cee867d6a17d45" => :sierra
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
  libgfortran = Formulary.factory("staticfloat/juliadeps/libgfortran")

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
            keg.change_install_name(bad_name.to_s, good_name.to_s, file.to_s)
          end
        end
      end
    end
  end

  gcc = Formulary.factory("gcc")
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
