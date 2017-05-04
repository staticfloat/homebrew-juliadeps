require 'formula'

class Glpk461 < Formula
  homepage 'http://www.gnu.org/software/glpk/'
  url 'http://ftpmirror.gnu.org/glpk/glpk-4.61.tar.gz'
  mirror 'http://ftp.gnu.org/gnu/glpk/glpk-4.61.tar.gz'
  sha256 '9866de41777782d4ce21da11b88573b66bb7858574f89c28be6967ac22dfaba9'

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
