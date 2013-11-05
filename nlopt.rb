require 'formula'

class Nlopt < Formula
  homepage 'https://projects.coin-or.org/Ipopt'
  url 'http://ab-initio.mit.edu/nlopt/nlopt-2.4.tar.gz'
  sha1 'e766f4c49fa5923fb45220f278c01c04c38fc369'

  bottle do
    root_url 'http://archive.org/download/julialang/bottles'
    cellar :any
    revision 1
    sha1 '08a94653c64cccd146b95ad5d3f0a14b36a0642e' => :mountain_lion
    sha1 '08a94653c64cccd146b95ad5d3f0a14b36a0642e' => :lion
    sha1 '08a94653c64cccd146b95ad5d3f0a14b36a0642e' => :snow_leopard
    sha1 '5abcbc704aa7fca3d8bc507382f03e08b1b33e4a' => :mavericks
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
