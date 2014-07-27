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
    revision 4
    sha1 'cd07fc8d0fc35d0bfcfa804afa73114d97d38a96' => :lion
    sha1 '81dc72448d93b0591919c50c13d0fe02c8d11f91' => :mavericks
    sha1 '52bfd1333e778e2db86528505f887bcc42bbfcfb' => :mountain_lion
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
