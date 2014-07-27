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
    revision 1
    sha1 '4cb42189f6599af1536b900a6903b7383dffa146' => :lion
    sha1 '80670a57d293dab0086408bb26a4480f99423ffe' => :mavericks
    sha1 'ae384727435ee149a008bbf4b446f40094767752' => :mountain_lion
  end

  def post_install
    # Symlink the libs into /lib as well, for easy access
    Find.find("#{lib}") do |path|
      if path =~ /#{lib}\/gcc\/[^\/]+\/[\d.]+\/lib[^\/]+\.dylib/
        system 'ln', '-fs', path, "#{lib}/#{File.basename(path)[0..-9]}.dylib"
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
