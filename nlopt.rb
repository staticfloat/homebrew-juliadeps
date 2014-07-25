require 'formula'

class Nlopt < Formula
  homepage 'https://projects.coin-or.org/Ipopt'
  url 'http://ab-initio.mit.edu/nlopt/nlopt-2.4.2.tar.gz'
  sha1 '838c399d8fffd7aa56b20231e0d7bd3462ca0226'

  bottle do
    root_url 'https://juliabottles.s3.amazonaws.com'
    cellar :any
    sha1 '191ae665e492b100443c23b6e051001b3ef037b9' => :lion
    sha1 '920fe73beebeb82220539e9bf15349fb0a149f0e' => :mavericks
    sha1 'b58d6ff4b118bc894d7138f53d0b52ee673463aa' => :mountain_lion
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
