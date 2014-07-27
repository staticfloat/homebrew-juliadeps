require 'formula'
require 'find'

class Libgfortran < Formula
  homepage 'http://gcc.gnu.org/wiki/GFortran'
  url 'https://github.com/staticfloat/homebrew-libgfortran-formula/archive/master.tar.gz'
  sha1 '09328c065c42051fab341e660837704a3b1f5d4a'
  version '4.9.1'
  revision 1

  bottle do
    root_url 'https://juliabottles.s3.amazonaws.com'
    cellar :any
    sha1 '0e91476d934cf816f7e9f4b2035167bc92631c7f' => :lion
    sha1 '3d74269dba281abbc1209beeabd9169054c8e6f8' => :mavericks
    sha1 '03d5dce3825381bc4f4c8e6543f1753c96f4a653' => :mountain_lion
  end

  def post_install
    # Symlink the libs into /lib as well, for easy access
    Find.find("#{lib}") do |path|
      if path =~ /#{lib}\/gcc\/[^\/]+\/[\d.]+\/lib[^\/]+\.dylib/
        system 'ln', '-s', path, "#{lib}/#{File.basename(path)[0..-9]}.dylib"
      end
    end
  end

  def install
    # To generate a libgfortran installation, steal libraries from gcc!
    if not Formula['gcc'].installed?
      odie "Must install gcc formula first!"
    end
    mkdir_p lib
    Find.find("#{Formula['gcc'].lib}/gcc") do |path|
      for f in ['quadmath.0', 'gcc_s.1', 'gfortran.3']
        if path =~ /.*#{f}\.dylib/
          dest = "#{path}"
          dest = "#{lib}/#{dest.tap{|s| s.slice!("#{Formula['gcc'].lib}/")}}"
          mkdir_p File.dirname(dest)
          system 'cp', path, dest
        end
      end
    end
  end
end
