require 'formula'

class Coinmp < Formula
  homepage 'http://www.coin-or.org/projects/CoinMP.xml'
  url 'http://www.coin-or.org/download/source/CoinMP/CoinMP-1.7.6.tgz'
  sha1 'f52c74abcbf55c72cd89f709db658ea33ed45154'

  bottle do
    root_url 'https://juliabottles.s3.amazonaws.com'
    cellar :any
    revision 1
    sha1 'dc81d8e2a5dc590cabc3de9e44a1810c1ab44113' => :lion
    sha1 '149c36ceb8f3561360e0d6b93c942044936aedf6' => :mavericks
    sha1 '5a3be6054fdda1edab5343d59da4458d09ba65d8' => :mountain_lion
  end

  depends_on :fortran => :build

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
