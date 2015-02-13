require 'formula'
require 'find'

# Ironically, we have to require ourselves to use fixup_libgfortran within ourselves
require "#{File.dirname(__FILE__)}/libgfortran"

class Libgfortran < Formula
  homepage 'http://gcc.gnu.org/wiki/GFortran'
  url 'https://github.com/staticfloat/homebrew-libgfortran-formula/archive/master.tar.gz'
  sha1 '09328c065c42051fab341e660837704a3b1f5d4a'
  version '4.9.2'
  revision 1

  bottle do
    root_url 'https://juliabottles.s3.amazonaws.com'
    cellar :any
    revision 1
    sha1 "02c8cc446567bd7b82050085017ad427f178b7e3" => :mountain_lion
    sha1 "2100e6fc878ffa8fedc50d54ef087d9844f9c633" => :mavericks
    sha1 "282f581b0661ccb445b524629ff4de71c6fe0f54" => :yosemite
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
  keg.pkgconfig_files.each do |file|
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
