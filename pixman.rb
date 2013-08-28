require 'formula'

class Pixman < Formula
  homepage 'http://cairographics.org/'
  url 'http://cairographics.org/releases/pixman-0.30.2.tar.gz'
  sha256 'bd988920ccd742310ddf5b363c7b278f11d69a3405a09d542162c84b46bff6e9'

  depends_on 'staticfloat/juliadeps/pkg-config' => :build

  option :universal

  bottle do
    root_url 'http://juliabottles.s3-website-us-east-1.amazonaws.com/bottles'
    cellar :any
    sha1 'b5449011bb17b60fc2ca848ba8a75486eaf805be' => :mountain_lion
    sha1 'b5449011bb17b60fc2ca848ba8a75486eaf805be' => :lion
    sha1 'b5449011bb17b60fc2ca848ba8a75486eaf805be' => :snow_leopard
  end

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

    system "./configure", *args
    system "make install"
  end
end
