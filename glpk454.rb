require 'formula'

class Glpk454 < Formula
  homepage 'http://www.gnu.org/software/glpk/'
  url 'http://ftpmirror.gnu.org/glpk/glpk-4.54.tar.gz'
  mirror 'http://ftp.gnu.org/gnu/glpk/glpk-4.54.tar.gz'
  sha1 '69d9c5d83271d34de1a58d2de2f7ababab975492'

  bottle do
    root_url 'https://juliabottles.s3.amazonaws.com'
    cellar :any
    sha1 '866ad909f2081a2d4bb4949426e2016e7a282550' => :lion
    sha1 '20ed969847046a4d7bbda59c2e02756d1c33975d' => :mavericks
    sha1 'd1148650ad7c8c3067c2ddf9625039324bb3db02' => :mountain_lion
  end

  def install
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make install"
  end
end
