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
    revision 5
    sha1 'ed1be16a9d8cbf8206888947702eb6a043378dda' => :lion
    sha1 'b81f74c97681bd77b0de355e354825f28df4cda8' => :mavericks
    sha1 'c3e62bb3f4d3d369a83d10848d84bec586639923' => :mountain_lion
  end

  def install
    # To generate a libgfortran installation, steal libraries from gcc!
    mkdir_p lib
    Find.find("#{Formula['gcc'].lib}/gcc") do |path|
      for f in ['quadmath.0', 'gcc_s.1', 'gfortran.3']
        if path =~ /#{lib}\/gcc\/[^\/]+\/[\d.]+\/lib[^\/]+\.dylib/
          system 'cp', path, lib
        end
      end
    end
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
