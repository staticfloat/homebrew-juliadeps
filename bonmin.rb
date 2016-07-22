require 'formula'

class Bonmin < Formula
  homepage 'https://projects.coin-or.org/Bonmin'
  url 'http://www.coin-or.org/download/pkgsource/Bonmin/Bonmin-1.8.4.tgz'
  sha256 'f533d351c1965ccdac823e8758e435b806786833fc2eff67ca5004013b25db51'

  depends_on 'pkg-config' => :build
  depends_on 'staticfloat/juliadeps/cbc'
  depends_on 'staticfloat/juliadeps/ipopt'

  bottle do
    cellar :any
    root_url 'https://juliabottles.s3.amazonaws.com'
    sha256 "7ab7608e41289cfeac476adf07badb84fbe0711e7a44015e9c826d155b3f54f2" => :mavericks
    sha256 "d7591823a58f4c672ffbb3ea8aad910e81a37283e19025da42c1e0702814e38a" => :yosemite
    sha256 "d8b1db5e5b921f0e518257e6b77c999dc67b11e172570c4c53f3eaab128bf2ed" => :el_capitan
  end

  def install
    system "./configure", "--prefix=#{prefix}"
    system "make"
    system "make test"
    ENV.deparallelize  # make install fails in parallel.
    system "make install"
  end
end
