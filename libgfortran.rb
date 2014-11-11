require 'formula'
require 'find'

class Libgfortran < Formula
  homepage 'http://gcc.gnu.org/wiki/GFortran'
  url 'https://github.com/staticfloat/homebrew-libgfortran-formula/archive/master.tar.gz'
  sha1 '09328c065c42051fab341e660837704a3b1f5d4a'
  version '4.9.2'

  bottle do
    root_url 'https://juliabottles.s3.amazonaws.com'
    cellar :any
    sha1 '3ce6625daa3170c28718417c4efd4d23479626a9' => :mavericks
    sha1 '51e68275e0b311b636b8ed86d7f3c4c0572f5558' => :mountain_lion
    sha1 "1614bd76272067ae3af66ed13ef8915a55ef75b6" => :yosemite
  end

  depends_on 'gcc' => :build

  def install
    # To generate a libgfortran installation, steal libraries from gcc!
    mkdir_p lib
    Find.find("#{Formula['gcc'].lib}/gcc") do |path|
      for f in ['quadmath.0', 'gcc_s.1', 'gfortran.3']
        if /.*\/#{version}\/lib#{f}.dylib/.match( path )
          system 'cp', path, lib
        end
      end
    end

    fixup_libgfortran(prefix)
  end
end

# Here, we're going to find all dylibs and install_name_tool them for libgfortran instead of gcc
def fixup_libgfortran(prefix)
  keg = Keg.for(prefix)
  libgfortran = Formula.factory("libgfortran")

  # For each dylib/executable within this keg
  keg.mach_o_files.each do |file|
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
end
