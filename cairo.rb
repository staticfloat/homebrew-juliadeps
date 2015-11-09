require "formula"

class Cairo < Formula
  homepage "http://cairographics.org/"
  url "http://cairographics.org/releases/cairo-1.14.2.tar.xz"
  mirror "https://www.mirrorservice.org/sites/ftp.netbsd.org/pub/pkgsrc/distfiles/cairo-1.14.2.tar.xz"
  sha256 "c919d999ddb1bbbecd4bbe65299ca2abd2079c7e13d224577895afa7005ecceb"

  bottle do
    root_url "https://juliabottles.s3.amazonaws.com"
    cellar :any
    sha256 "a7dfb100d89da3219da13d8c8609ef8f1137fb5a0a24e46bf06748946ac4af1e" => :mountain_lion
    sha256 "84e8622a94d0f3c3c2dfef9299e9e04526bc677c6a0acc6d1d4d48c723744d18" => :mavericks
    sha256 "1fdd86a0ab7556a5580bd4ca4a5a6e9fe5b3d2fa62ab3169d5b90657fc581c56" => :yosemite
  end

  option :universal

  depends_on "staticfloat/juliadeps/pkg-config" => :build
  depends_on "freetype"
  depends_on "staticfloat/juliadeps/fontconfig"
  depends_on "libpng"
  depends_on "staticfloat/juliadeps/pixman"
  depends_on "staticfloat/juliadeps/glib"

  def install
    ENV.universal_binary if build.universal?

    # We always build without x
    args = %W[
      --disable-dependency-tracking
      --prefix=#{prefix}
      --enable-gobject=yes
      --enable-svg=yes
      --enable-tee=yes
      --enable-quartz-image
      --enable-xcb=no
      --enable-xlib=no
      --enable-xlib-xrender=no
    ]

    system "./configure", *args
    system "make", "install"
  end
end
