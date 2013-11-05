require 'formula'

class Pixman < Formula
  homepage 'http://cairographics.org/'
  url 'http://cairographics.org/releases/pixman-0.30.2.tar.gz'
  sha256 'bd988920ccd742310ddf5b363c7b278f11d69a3405a09d542162c84b46bff6e9'

  bottle do
    root_url 'http://archive.org/download/julialang/bottles'
    cellar :any
    revision 2
    sha1 'b7d1a7c9f68e29daff09c826867391b0d917ce7e' => :mountain_lion
    sha1 'b7d1a7c9f68e29daff09c826867391b0d917ce7e' => :lion
    sha1 'b7d1a7c9f68e29daff09c826867391b0d917ce7e' => :snow_leopard
    sha1 'b7d1a7c9f68e29daff09c826867391b0d917ce7e' => :mavericks
  end

  depends_on 'staticfloat/juliadeps/pkg-config' => :build

  option :universal

  fails_with :llvm do
    build 2336
    cause <<-EOS.undent
      Building with llvm-gcc causes PDF rendering issues in Cairo.
      https://trac.macports.org/ticket/30370
      See Homebrew issues #6631, #7140, #7463, #7523.
      EOS
  end

  def install
    ENV.universal_binary if build.universal?

    # Disable gtk as it is only used to build tests
    args = %W[--disable-dependency-tracking
              --disable-gtk
              --prefix=#{prefix}]

    args << "--disable-mmx" if ENV.compiler == :clang

    # Don't use TLS, use pthreads instead
    args << "ac_cv_tls=none"

    system "./configure", *args
    system "make install"
  end
end
