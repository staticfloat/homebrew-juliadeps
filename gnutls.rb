require 'formula'

class Gnutls < Formula
  homepage 'http://gnutls.org'
  url 'ftp://ftp.gnutls.org/gcrypt/gnutls/v3.1/gnutls-3.1.18.tar.xz'
  mirror 'http://mirrors.dotsrc.org/gcrypt/gnutls/v3.1/gnutls-3.1.18.tar.xz'
  sha1 '360cdb86c1bb6494c27901b5d4c8815b37d5bd4c'

  bottle do
    root_url 'http://archive.org/download/julialang/bottles'
    cellar :any
    sha1 '77af580f4e28b267813877198f5e8616dec4612c' => :snow_leopard_or_later
  end

  depends_on 'xz' => :build
  depends_on 'staticfloat/juliadeps/pkg-config' => :build
  depends_on 'staticfloat/juliadeps/libtasn1'
  depends_on 'staticfloat/juliadeps/nettle'

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
