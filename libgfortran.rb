require 'formula'
require 'find'

class Libgfortran < Formula
  homepage 'http://gcc.gnu.org/wiki/GFortran'
  url 'https://github.com/staticfloat/homebrew-libgfortran-formula/archive/master.tar.gz'
  sha1 '09328c065c42051fab341e660837704a3b1f5d4a'
  version '4.9.1'

  depends_on 'gcc' => :build

  bottle do
    root_url 'https://juliabottles.s3.amazonaws.com'
    cellar :any
    revision 8
    sha1 '83fb086bb40fc6d102b94d1c8a4ea1af2bc0ecd6' => :lion
    sha1 '82ec1addebad215e4a20393da666d426087e24aa' => :mavericks
    sha1 '196cb0da8ab3825bf124ebcb0415502a7871e146' => :mountain_lion
  end

  def install
    # To generate a libgfortran installation, steal libraries from gcc!
    mkdir_p lib
    Find.find("#{Formula['gcc'].lib}/gcc") do |path|
      for f in ['quadmath.0', 'gcc_s.1', 'gfortran.3']
        if /.*\/4.9.1\/lib#{f}.dylib/.match( path )
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
