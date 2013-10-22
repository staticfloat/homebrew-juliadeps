require 'formula'

class Libgfortran < Formula
  homepage 'http://gcc.gnu.org/wiki/GFortran'
  url 'http://ftpmirror.gnu.org/gcc/gcc-4.8.1/gcc-4.8.1.tar.bz2'
  mirror 'http://ftp.gnu.org/gnu/gcc/gcc-4.8.1/gcc-4.8.1.tar.bz2'
  sha1 '4e655032cda30e1928fcc3f00962f4238b502169'

  bottle do
    root_url 'http://archive.org/download/julialang/bottles'
    cellar :any
    sha1 'fe137c44e2b3a6da1b5eaefe8c1e20d5c29642ce' => :mountain_lion
    sha1 'fe137c44e2b3a6da1b5eaefe8c1e20d5c29642ce' => :lion
    sha1 'fe137c44e2b3a6da1b5eaefe8c1e20d5c29642ce' => :snow_leopard
  end

  def post_install
    # This is here to symlink the libs to alternate locations where they could be installed
    mkdir_p prefix+'gfortran/lib'
    for f in ['quadmath.0', 'gcc_s.1', 'gfortran.3']
      quiet_system 'ln', '-fs', lib+"lib#{f}.dylib", prefix+"gfortran/lib/lib#{f}.dylib"
      quiet_system 'ln', '-fs', lib+"lib#{f}.dylib", prefix+"gfortran/lib/lib#{f[0..-3]}.dylib"
      quiet_system 'ln', '-fs', lib+"lib#{f}.dylib", lib+"lib#{f[0..-3]}.dylib"
    end
  end

  def install
    opoo "This formula is bottle-only!  If you actually want to install gfortran, use the gfortran formula included by brew!"
  end
end
