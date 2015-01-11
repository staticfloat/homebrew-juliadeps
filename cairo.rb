require 'formula'

class Cairo < Formula
  homepage 'http://cairographics.org/'
  url "http://cairographics.org/releases/cairo-1.14.0.tar.xz"
  mirror "http://www.mirrorservice.org/sites/ftp.netbsd.org/pub/pkgsrc/distfiles/cairo-1.14.0.tar.xz"
  sha256 "2cf5f81432e77ea4359af9dcd0f4faf37d015934501391c311bfd2d19a0134b7"
  
  bottle do
    root_url 'https://juliabottles.s3.amazonaws.com'
    cellar :any
  end





  option :universal

  depends_on 'staticfloat/juliadeps/pkg-config' => :build
  depends_on 'freetype'
  depends_on 'fontconfig'
  depends_on 'libpng'
  depends_on 'pixman'
  depends_on 'staticfloat/juliadeps/glib'
  depends_on 'xz'=> :build

  env :std if build.universal?

  def install
    ENV.universal_binary if build.universal?

    # We always build without x
    args = %W[
      --disable-dependency-tracking
      --prefix=#{prefix}
      --enable-xlib=no
      --enable-xlib-xrender=no
      --enable-quartz-image=yes
      --enable-gobject=yes
      --enable-svg=yes
    ]

    system "./configure", *args
    system "make install"
  end
end
