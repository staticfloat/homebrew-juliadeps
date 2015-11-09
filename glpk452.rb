require 'formula'

class Glpk452 < Formula
  homepage 'http://www.gnu.org/software/glpk/'
  url 'http://ftpmirror.gnu.org/glpk/glpk-4.52.tar.gz'
  mirror 'http://ftp.gnu.org/gnu/glpk/glpk-4.52.tar.gz'
  sha256 '9a5dab356268b4f177c33e00ddf8164496dc2434e83bd1114147024df983a3bb'

  bottle do
    root_url 'https://juliabottles.s3.amazonaws.com'
    cellar :any
    sha1 '4e5035b64862a8ecf47637de9e7e2c0135e8d6e4' => :mavericks
    sha1 "1ccd6325aafa76657f23366b6c8e0821f16a5ec0" => :yosemite
    sha256 "07cbe9cbdb3736fe6c558a3a1177de2a360a08527a27d88ab8a050599d119c1a" => :el_capitan
  end

  def install
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make install"
  end
end
