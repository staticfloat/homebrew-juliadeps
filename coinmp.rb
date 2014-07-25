require 'formula'

class Coinmp < Formula
  homepage 'http://www.coin-or.org/projects/CoinMP.xml'
  url 'http://www.coin-or.org/download/source/CoinMP/CoinMP-1.7.6.tgz'
  sha1 'f52c74abcbf55c72cd89f709db658ea33ed45154'

  bottle do
    root_url 'https://juliabottles.s3.amazonaws.com'
    cellar :any
    sha1 '747c85fb7f7f109e062a7db03bd42e1dfffa1d39' => :lion
    sha1 '159c080692ae45a7871082325f2999cbd90113d8' => :mavericks
    sha1 'f4532f3df79790ad0a5b4d54287418a0a5c2105c' => :mountain_lion
  end

  depends_on 'staticfloat/juliadeps/libgfortran'


  def install
    # build without lapack until OpenBLAS issue 306 is resolved
    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}", "--without-lapack", 
                          "--enable-dependency-linking"
    system "make"
    ENV.deparallelize  # make install fails in parallel.
    system "make install"

  end
end
