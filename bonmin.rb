require 'formula'

class Bonmin < Formula
  homepage 'https://projects.coin-or.org/Bonmin'
  url 'http://www.coin-or.org/download/pkgsource/Bonmin/Bonmin-1.8.2.tgz'
  sha1 'c2ca2ae318088ad176e9153825b82c4bb9e5ade9'

  depends_on 'staticfloat/juliadeps/pkg-config' => :build
  depends_on 'staticfloat/juliadeps/cbc'
  depends_on 'staticfloat/juliadeps/ipopt'

  bottle do
    cellar :any
    root_url 'https://juliabottles.s3.amazonaws.com'
    sha256 "fb0a2c997fcc7492fa184451fad8e42be4e80e6ff107da8ecd9b0df9fd2c7fa6" => :mavericks
    sha256 "0d03a0f59ba3135bedc954871f972e6e5746345cfaa333af3f70931345b57c6a" => :yosemite
  end

  def install
    system "./configure", "--prefix=#{prefix}"
    system "make"
    system "make test"
    ENV.deparallelize  # make install fails in parallel.
    system "make install"
  end
end
