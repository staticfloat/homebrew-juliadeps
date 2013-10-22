require 'formula'

class Libgfortran < Formula
  homepage 'http://gcc.gnu.org/wiki/GFortran'
  url 'http://ftpmirror.gnu.org/gcc/gcc-4.8.1/gcc-4.8.1.tar.bz2'
  mirror 'http://ftp.gnu.org/gnu/gcc/gcc-4.8.1/gcc-4.8.1.tar.bz2'
  sha1 '4e655032cda30e1928fcc3f00962f4238b502169'

  bottle do
    root_url 'http://archive.org/download/julialang/bottles'
    cellar :any
    sha1 '9577f77038188a4f4245dded282670e868994cef' => :mountain_lion
    sha1 '9577f77038188a4f4245dded282670e868994cef' => :lion
    sha1 '9577f77038188a4f4245dded282670e868994cef' => :snow_leopard
  end

  def post_install
    # This is here to symlink the libs to alternate locations where they could be installed
    mkdir prefix+'gfortran/lib'
    for lib in ['quadmath.0', 'gcc_s.1', 'gfortran.3']
      quiet_system 'ln', '-fs', prefix+"gfortran/lib/lib#{lib}.dylib", lib+"lib#{lib}.dylib"
      quiet_system 'ln', '-fs', prefix+"gfortran/lib/lib#{lib[0..-3]}.dylib", lib+"lib#{lib}.dylib"
      quiet_system 'ln', '-fs', lib+"lib#{lib[0..-3]}.dylib", lib+"lib#{lib}.dylib"
    end
  end

  def install
    opoo "This formula is bottle-only!  If you actually want to install gfortran, use the gfortran formula included by brew!"
  end
end
