require "formula"

class Cairo < Formula
  homepage "http://cairographics.org/"
  url "http://cairographics.org/releases/cairo-1.14.2.tar.xz"
  mirror "https://www.mirrorservice.org/sites/ftp.netbsd.org/pub/pkgsrc/distfiles/cairo-1.14.2.tar.xz"
  sha256 "c919d999ddb1bbbecd4bbe65299ca2abd2079c7e13d224577895afa7005ecceb"

  bottle do
    root_url "https://juliabottles.s3.amazonaws.com"
    cellar :any
  end

  option :universal

  depends_on "staticfloat/juliadeps/pkg-config" => :build
  depends_on "staticfloat/juliadeps/freetype"
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
