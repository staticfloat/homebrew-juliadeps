require 'formula'

class Cairo < Formula
  homepage 'http://cairographics.org/'
  url "http://cairographics.org/releases/cairo-1.14.0.tar.xz"
  mirror "http://www.mirrorservice.org/sites/ftp.netbsd.org/pub/pkgsrc/distfiles/cairo-1.14.0.tar.xz"
  sha256 "2cf5f81432e77ea4359af9dcd0f4faf37d015934501391c311bfd2d19a0134b7"
  
  bottle do
    root_url 'https://juliabottles.s3.amazonaws.com'
    cellar :any
    sha1 "ccdbd258f4d9bdd9b7151b793e18290dde673c6d" => :yosemite
    sha1 "c17c00dda78731dd4293e4c7f7fcc1f3d3384997" => :mavericks
    sha1 "cbf83223fabea2a31896d5172020d41134e03dc1" => :mountain_lion
  end

  option :universal

  depends_on 'staticfloat/juliadeps/pkg-config' => :build
  depends_on 'staticfloat/juliadeps/freetype'
  depends_on 'staticfloat/juliadeps/fontconfig'
  depends_on 'libpng'
  depends_on 'staticfloat/juliadeps/pixman'
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
