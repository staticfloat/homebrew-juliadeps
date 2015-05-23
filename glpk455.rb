require 'formula'

class Glpk455 < Formula
  homepage 'http://www.gnu.org/software/glpk/'
  url 'http://ftpmirror.gnu.org/glpk/glpk-4.55.tar.gz'
  mirror 'http://ftp.gnu.org/gnu/glpk/glpk-4.55.tar.gz'
  sha256 '37090d7f16796ec1034496e182a39d5cc8bb7c9fb5dc48a38b13d620bf2b1de7'

  bottle do
    root_url 'https://juliabottles.s3.amazonaws.com'
    cellar :any
  end

  def install
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make install"
  end
end
