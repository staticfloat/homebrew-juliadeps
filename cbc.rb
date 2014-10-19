require 'formula'

class Cbc < Formula
  homepage 'http://www.coin-or.org/projects/Cbc.xml'
  url 'http://www.coin-or.org/download/source/Cbc/Cbc-2.8.12.tgz'
  sha1 '7739f1841da5b8db0ee08bc21bd1ba05bd9d8432'

  bottle do
    root_url 'https://juliabottles.s3.amazonaws.com'
    cellar :any
    revision 1
    sha1 'def6b5f597219cab01f6b71aa754abaccab4505b' => :lion
    sha1 '609fde1685f0ce02da2adaec0eaf87e75923d3f2' => :mavericks
    sha1 'de63aea362dbc498af3e8d2bbbd06d85cb937b69' => :mountain_lion
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
