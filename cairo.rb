require "formula"

class Cairo < Formula
  homepage 'http://cairographics.org/'
  url 'http://cairographics.org/releases/cairo-1.14.4.tar.xz'
  mirror 'https://www.mirrorservice.org/sites/ftp.netbsd.org/pub/pkgsrc/distfiles/cairo-1.14.4.tar.xz'
  sha256 'f6ec9c7c844db9ec011f0d66b57ef590c45adf55393d1fc249003512522ee716'

  bottle do
    root_url "https://juliabottles.s3.amazonaws.com"
    cellar :any
    sha256 "c55ee9fe1dd2511108fb2b6001f4ba267f0cf9bc3be59e86541ac2a959c2a5ff" => :mavericks
    sha256 "d98bf479fabd5d5255d8dc611bdb65c07800e6b9628b9c75c56a7450ce5ef9bb" => :yosemite
    sha256 "48030484b47ea06be851d4abc6f7e5a87b21bb8fc0d5ec00314caad7156d384f" => :el_capitan
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
