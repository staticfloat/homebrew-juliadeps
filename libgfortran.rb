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

  def install
    opoo "This formula is bottle-only!  If you actually want to install gfortran, use the gfortran formula included by brew!"
  end
end
