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
    root_url 'http://archive.org/download/julialang/bottles'
    cellar :any
    revision 1
    sha1 '1d65e4ea9a390cee8a00194c57d232bde1aac37c' => :snow_leopard_or_later
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

    if build.with? 'glib'
      args << '--enable-gobject=yes'
    else
      args << '--enable-gobject=no'
    end

    system "./configure", *args
    system "make install"
  end
end
