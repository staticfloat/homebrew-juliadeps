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
    revision 3
    sha1 'd867df01712b78ae91840532612194a30a001d89' => :lion
    sha1 '0dc8ecf57195f229c17e8e624927fb309ef3f191' => :mavericks
    sha1 '0df479387adeee321e4ab6f7b557c11c7b0e4d50' => :mountain_lion
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
