require 'formula'

class Nlopt < Formula
  homepage 'https://projects.coin-or.org/Ipopt'
  url 'http://ab-initio.mit.edu/nlopt/nlopt-2.4.2.tar.gz'
  sha256 '8099633de9d71cbc06cd435da993eb424bbcdbded8f803cdaa9fb8c6e09c8e89'
  revision 1

  bottle do
    root_url 'https://juliabottles.s3.amazonaws.com'
    cellar :any
    sha256 "94412276f8a9dd0008c5f9a6deacb81b33819f22e381029e632958e3270f42b6" => :mavericks
    sha256 "9f6bad6247ef3718d3cad33881256f2410ad47bb5d2a81af12641c48465178e0" => :yosemite
    sha256 "e02cd1e985f2c66cb911875b445d98ca69fcdc88abb95a17cdd2d7337b90c179" => :el_capitan
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
