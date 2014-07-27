require 'formula'
require 'find'

class Libgfortran < Formula
  homepage 'http://gcc.gnu.org/wiki/GFortran'
  url 'https://github.com/staticfloat/homebrew-libgfortran-formula/archive/master.tar.gz'
  sha1 '09328c065c42051fab341e660837704a3b1f5d4a'
  version '4.9.1'

  bottle do
    root_url 'https://juliabottles.s3.amazonaws.com'
    cellar :any
    revision 3
    sha1 '82e9e90b5e39746513e4d7d061b6036b4aabee13' => :mavericks
    sha1 'cad0815ee3825359db88e1136340b7f834ad5a1a' => :lion
    sha1 '531c655fde6f273b77e4e8b6e0c2cf6ef05673c5' => :mountain_lion
  end

  def post_install
    # Symlink the libs into /lib as well, for easy access
    Find.find("#{lib}") do |path|
      if path =~ /#{lib}\/gcc\/[^\/]+\/[\d.]+\/lib[^\/]+\.dylib/
        system 'ln', '-fs', path, "#{lib}/#{File.basename(path)[0..-9]}.dylib"
      end
    end

    # Symlink this whole keg over into "gcc" as well, if it doesn't already exist
    gcc_keg = "#{HOMEBREW_CELLAR}/gcc"
    if !File.directory? gcc_keg
      system 'ln', '-fs', "#{HOMEBREW_CELLAR}/libgfortran", gcc_keg
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
