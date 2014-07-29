require 'formula'

# Use a mirror because of:
# http://lists.cairographics.org/archives/cairo/2012-September/023454.html

class Cairo < Formula
  homepage 'http://cairographics.org/'
  url 'http://cairographics.org/releases/cairo-1.12.16.tar.xz'
  mirror 'https://downloads.sourceforge.net/project/machomebrew/mirror/cairo-1.12.16.tar.xz'
  sha256 '2505959eb3f1de3e1841023b61585bfd35684b9733c7b6a3643f4f4cbde6d846'

  option :universal

  bottle do
    root_url 'https://juliabottles.s3.amazonaws.com'
    cellar :any
    revision 2
    sha1 '9cc399dec6482c32dd7a5a76ffc554fb42463526' => :lion
    sha1 '933279e51c31ee7fb56bb956d1398e26ecb60e76' => :mavericks
    sha1 'ffa1877b856e7813d2bad722fcaf893b205ba220' => :mountain_lion
  end

  depends_on 'staticfloat/juliadeps/pkg-config' => :build
  depends_on 'xz'=> :build
  depends_on 'freetype'
  depends_on 'libpng'
  depends_on 'pixman'
  depends_on 'staticfloat/juliadeps/glib'

  env :std if build.universal?

  def install
    ENV.universal_binary if build.universal?

    args = %W[
      --disable-dependency-tracking
      --prefix=#{prefix}
    ]

    # We always built without x
    args << '--enable-xlib=no' << '--enable-xlib-xrender=no'
    args << '--enable-quartz-image=yes'
    args << '--enable-gobject=yes'

    system "./configure", *args
    system "make install"
  end
end
