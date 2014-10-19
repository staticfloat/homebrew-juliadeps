require 'formula'

class Cbc < Formula
  homepage 'http://www.coin-or.org/projects/Cbc.xml'
  url 'http://www.coin-or.org/download/source/Cbc/Cbc-2.8.12.tgz'
  sha1 '7739f1841da5b8db0ee08bc21bd1ba05bd9d8432'

  bottle do
    root_url 'https://juliabottles.s3.amazonaws.com'
    cellar :any
    revision 1
    sha1 '17cdf5014258b08428667d6012984efc516ca930' => :lion
    sha1 '9e998d8b6789faa90079e292f7b11e8501a235c5' => :mavericks
    sha1 '0075d399760f53fe10847ea7c4c9c4f2e6b18f00' => :mountain_lion
  end

  def install
    # build without lapack until Julia issue 4923 is resolved
    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}", "--without-lapack", 
                          "--enable-dependency-linking",
                          "--enable-cbc-parallel"
    system "make"
    ENV.deparallelize  # make install fails in parallel.
    system "make install"

  end
end
