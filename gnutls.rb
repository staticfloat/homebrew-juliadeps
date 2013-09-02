require 'formula'

class Gnutls < Formula
  homepage 'http://gnutls.org'
  url 'ftp://ftp.gnutls.org/gcrypt/gnutls/v3.1/gnutls-3.1.10.tar.xz'
  sha1 '1097644b0e58754217c4f9edbdf68e9f7aa7e08d'

  depends_on 'staticfloat/juliadeps/xz' => :build
  depends_on 'staticfloat/juliadeps/pkg-config' => :build
  depends_on 'staticfloat/juliadeps/libtasn1'
  depends_on 'staticfloat/juliadeps/nettle'

  bottle do
    root_url 'http://juliabottles.s3-website-us-east-1.amazonaws.com/bottles'
    cellar :any
    sha1 'aa0caae7f8af3c88d2faa013255c34ec5a64c45c' => :mountain_lion
    sha1 'aa0caae7f8af3c88d2faa013255c34ec5a64c45c' => :lion
    sha1 'aa0caae7f8af3c88d2faa013255c34ec5a64c45c' => :snow_leopard
  end

  fails_with :llvm do
    build 2326
    cause "Undefined symbols when linking"
  end

  def install
    system "./configure", "--disable-dependency-tracking",
                          "--disable-static",
                          "--prefix=#{prefix}"
    system "make install"

    # certtool shadows the OS X certtool utility
    mv bin+'certtool', bin+'gnutls-certtool'
    mv man1+'certtool.1', man1+'gnutls-certtool.1'
  end
end
