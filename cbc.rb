require 'formula'

class Cbc < Formula
  homepage 'http://www.coin-or.org/projects/Cbc.xml'
  url 'http://www.coin-or.org/download/source/Cbc/Cbc-2.9.2.tgz'
  sha1 '60c0b9be005f3bfcf21d22167ff9539eaf337876'

  bottle do
    root_url 'https://juliabottles.s3.amazonaws.com'
    cellar :any
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
