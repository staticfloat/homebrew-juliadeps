require 'formula'
require 'find'

class Libgfortran < Formula
  homepage 'http://gcc.gnu.org/wiki/GFortran'
  url 'https://github.com/staticfloat/homebrew-libgfortran-formula/archive/master.tar.gz'
  sha1 '09328c065c42051fab341e660837704a3b1f5d4a'
  version '4.9.1'
  revision 2

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

          if dest =~ /#{lib}\/gcc\/[^\/]+\/[\d.]+\/lib[^\/]+\.dylib/
            system 'ln', '-s', dest, "#{lib}/#{File.basename(path)[0..-9]}.dylib"
          end
        end
      end
    end
  end
end

