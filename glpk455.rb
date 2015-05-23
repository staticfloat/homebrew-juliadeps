require 'formula'

class Glpk455 < Formula
  homepage 'http://www.gnu.org/software/glpk/'
  url 'http://ftpmirror.gnu.org/glpk/glpk-4.55.tar.gz'
  mirror 'http://ftp.gnu.org/gnu/glpk/glpk-4.55.tar.gz'
  sha256 '37090d7f16796ec1034496e182a39d5cc8bb7c9fb5dc48a38b13d620bf2b1de7'

  bottle do
    root_url 'https://juliabottles.s3.amazonaws.com'
    cellar :any
    sha256 "bef343addd233b4898654df05cf2fc017ee6c5d1e1ed9bb5245118431dffafd8" => :mountain_lion
    sha256 "5e4c0b71643e88bf4949f9a6929fe975ba6635ec5979b047442590fd7c26c11d" => :yosemite
    sha256 "1465b8cd1eb4a6fa6c5a791422d24aa8496e224962c5d2fcd469deeb99caef6a" => :mavericks
  end

  def install
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make install"
  end
end
