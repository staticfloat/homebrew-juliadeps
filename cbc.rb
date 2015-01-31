require 'formula'

class Cbc < Formula
  homepage 'http://www.coin-or.org/projects/Cbc.xml'
  url 'http://www.coin-or.org/download/source/Cbc/Cbc-2.9.2.tgz'
  sha1 '60c0b9be005f3bfcf21d22167ff9539eaf337876'

  bottle do
    root_url 'https://juliabottles.s3.amazonaws.com'
    cellar :any
    revision 1
    sha1 '17cdf5014258b08428667d6012984efc516ca930' => :lion
    sha1 '9e998d8b6789faa90079e292f7b11e8501a235c5' => :mavericks
    sha1 '0075d399760f53fe10847ea7c4c9c4f2e6b18f00' => :mountain_lion
    sha1 "7aadbe851f313b7c7b20dcd5ff9906784b866dbb" => :yosemite
  end

  def install
    # build without lapack until Julia issue 4923 is resolved
    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}", "--without-lapack",
                          "--enable-cbc-parallel"
    system "make"
    ENV.deparallelize  # make install fails in parallel.
    system "make install"

  end
end
