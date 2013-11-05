require 'formula'

class Nlopt < Formula
  homepage 'https://projects.coin-or.org/Ipopt'
  url 'http://ab-initio.mit.edu/nlopt/nlopt-2.4.tar.gz'
  sha1 'e766f4c49fa5923fb45220f278c01c04c38fc369'

  bottle do
    root_url 'http://archive.org/download/julialang/bottles'
    cellar :any
    revision 1
    sha1 '127ffddbb846f95daaec7ba32e608f3a93c27cb8' => :mountain_lion
    sha1 '127ffddbb846f95daaec7ba32e608f3a93c27cb8' => :lion
    sha1 '127ffddbb846f95daaec7ba32e608f3a93c27cb8' => :snow_leopard
    sha1 '127ffddbb846f95daaec7ba32e608f3a93c27cb8' => :mavericks
  end

  def install
    ENV.deparallelize  # make install fails in parallel.

    system "./configure", "--enable-shared",
                          "--without-guile",
                          "--without-python",
                          "--without-octave",
                          "--without-matlab",
                          "--without-threadlocal",
                          "--with-cxx",
                          "--prefix=#{prefix}"
    system "make"
    system "make install"
  end
end
