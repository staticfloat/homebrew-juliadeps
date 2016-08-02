require 'formula'

class Glpk452 < Formula
  homepage 'http://www.gnu.org/software/glpk/'
  url 'http://ftpmirror.gnu.org/glpk/glpk-4.52.tar.gz'
  mirror 'http://ftp.gnu.org/gnu/glpk/glpk-4.52.tar.gz'
  sha256 '9a5dab356268b4f177c33e00ddf8164496dc2434e83bd1114147024df983a3bb'

  bottle do
    root_url 'https://juliabottles.s3.amazonaws.com'
    cellar :any
    sha256 "75ad2a6a10fdb912b55fee99620b22016002326571b8aa93ea5703d741070f2e" => :mavericks
    sha256 "aaf8bdcfee813a85d69c869bfd239fc08925a80e04a41abd949e77721df26ad1" => :yosemite
    sha256 "07cbe9cbdb3736fe6c558a3a1177de2a360a08527a27d88ab8a050599d119c1a" => :el_capitan
  end

  def install
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make install"
  end
end
