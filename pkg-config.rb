require 'formula'

class PkgConfig < Formula
  homepage 'http://pkgconfig.freedesktop.org'
  url 'http://pkgconfig.freedesktop.org/releases/pkg-config-0.28.tar.gz'
  mirror 'http://fossies.org/unix/privat/pkg-config-0.28.tar.gz'
  sha256 '6b6eb31c6ec4421174578652c7e141fdaae2dabad1021f420d8713206ac1f845'

  bottle do
    root_url 'http://archive.org/download/julialang/bottles'
    cellar :any
    revision 1
    sha1 '633440ecda8902b62c495fa6fc0e5e014a9b607b' => :mavericks
    sha1 '633440ecda8902b62c495fa6fc0e5e014a9b607b' => :mountain_lion
    sha1 '633440ecda8902b62c495fa6fc0e5e014a9b607b' => :lion
    sha1 '633440ecda8902b62c495fa6fc0e5e014a9b607b' => :snow_leopard
  end

  def install
    paths = %W[
        #{HOMEBREW_PREFIX}/lib/pkgconfig
        #{HOMEBREW_PREFIX}/share/pkgconfig
        /usr/local/lib/pkgconfig
        /usr/lib/pkgconfig
      ].uniq

    args = %W[
        --disable-debug
        --prefix=#{prefix}
        --disable-host-tool
        --with-internal-glib
        --with-pc-path=#{paths*':'}
      ]
    args << "CC=#{ENV.cc} #{ENV.cflags}" unless MacOS::CLT.installed?

    system "./configure", *args

    system "make"
    system "make check"
    system "make install"
  end
end
