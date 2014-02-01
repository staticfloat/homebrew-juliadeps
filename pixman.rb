require 'formula'

class Pixman < Formula
  homepage 'http://cairographics.org/'
  url 'http://cairographics.org/releases/pixman-0.32.4.tar.gz'
  sha256 '80c7ed420e8a3ae749800241e6347c3d55681296cab71384be7969cd9e657e84'

  depends_on 'staticfloat/juliadeps/pkg-config' => :build

  bottle do
    root_url 'http://archive.org/download/julialang/bottles'
    cellar :any
    sha1 '7e46457ffdd0c6012c9067f8e6a161e796431ac3' => :snow_leopard_or_later
  end

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

    system "./configure", *args
    system "make install"
  end
end
