require 'formula'

class Cbc < Formula
  homepage 'http://www.coin-or.org/projects/Cbc.xml'
  url 'http://www.coin-or.org/download/source/Cbc/Cbc-2.9.7.tgz'
  sha256 '637d080d381e620888d032cba28a3f1f8199f3b5619a3b763aa1470fda543817'

  bottle do
    root_url 'https://juliabottles.s3.amazonaws.com'
    cellar :any
    rebuild 1
    sha256 "169f90ae3e3bbd57319d56a04e956673eac26b11892d14934dc96660175cfe51" => :mavericks
    sha256 "1ab5239df38ee1e9c34725296d77ae95f2e9397f2d9fdf1c680f2bcb3c9b507f" => :yosemite
    sha256 "5da729509a252b06654cf0ee312dd8f74bd9e477ac7f9567c6d332e2cc84c40c" => :el_capitan
    sha256 "f384ee062fe2ccabdfeaf07f83904d6b566553186e39885bb44aeb063b7a02dd" => :sierra
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
