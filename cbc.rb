require 'formula'

class Cbc < Formula
  homepage 'http://www.coin-or.org/projects/Cbc.xml'
  url 'http://www.coin-or.org/download/source/Cbc/Cbc-2.9.7.tgz'
  sha256 '637d080d381e620888d032cba28a3f1f8199f3b5619a3b763aa1470fda543817'

  bottle do
    root_url 'https://juliabottles.s3.amazonaws.com'
    cellar :any
    sha256 "064c755b2e58c1dbe9f785d2d06d577c9512c51e0534a1fd83a8a204ad49b3b4" => :mavericks
    sha256 "c92032a65a43fe484e115d2104a5072925150eb18fb14edc8f346efc19f62034" => :yosemite
    sha256 "39641cf3667671b186710f5744c1f0c4a499e07644f992c0d23636b456c97a60" => :el_capitan
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
