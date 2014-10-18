require 'formula'

class Cbc < Formula
  homepage 'http://www.coin-or.org/projects/Cbc.xml'
  url 'http://www.coin-or.org/download/source/Cbc/Cbc-2.8.12.tgz'
  sha1 '7739f1841da5b8db0ee08bc21bd1ba05bd9d8432'

  bottle do
    root_url 'https://juliabottles.s3.amazonaws.com'
    cellar :any
    sha1 '0d628178e187a908084d075887563a5bd330e764' => :lion
    sha1 '9a354ee0af885cdb769629876499ec17c8c4ca5d' => :mavericks
    sha1 'cf7db49d60cc22889fc325a7f00997a53615da0b' => :mountain_lion
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
