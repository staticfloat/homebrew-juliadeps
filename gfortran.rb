require 'formula'

class Gfortran < Formula
  homepage 'http://gcc.gnu.org/wiki/GFortran'
  url 'http://ftpmirror.gnu.org/gcc/gcc-4.8.2/gcc-4.8.2.tar.bz2'
  mirror 'http://ftp.gnu.org/gnu/gcc/gcc-4.8.2/gcc-4.8.2.tar.bz2'
  sha1 '810fb70bd721e1d9f446b6503afe0a9088b62986'

  def install
    opoo "This formula is bottle-only!  If you actually want to install gfortran, use the gfortran formula provided by brew!"
  end
end
