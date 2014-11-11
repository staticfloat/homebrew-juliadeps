require 'formula'

class Glpk452 < Formula
  homepage 'http://www.gnu.org/software/glpk/'
  url 'http://ftpmirror.gnu.org/glpk/glpk-4.52.tar.gz'
  mirror 'http://ftp.gnu.org/gnu/glpk/glpk-4.52.tar.gz'
  sha1 '44b30b0de777a0a07e00615ac6791af180ff4d2c'

  bottle do
    root_url 'https://juliabottles.s3.amazonaws.com'
    cellar :any
    sha1 '1cfc6a3e39ab1c3861cd2d33c88b31dfecbada9a' => :lion
    sha1 '4e5035b64862a8ecf47637de9e7e2c0135e8d6e4' => :mavericks
    sha1 'd5bbd247ef1c24fe54d0de67bb70ef227d6a33c1' => :mountain_lion
    sha1 "1ccd6325aafa76657f23366b6c8e0821f16a5ec0" => :yosemite
  end

  def install
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make install"
  end
end
