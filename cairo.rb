require 'formula'

# Use a mirror because of:
# http://lists.cairographics.org/archives/cairo/2012-September/023454.html

class Cairo < Formula
  homepage 'http://cairographics.org/'
  url 'http://cairographics.org/releases/cairo-1.12.14.tar.xz'
  mirror 'https://downloads.sourceforge.net/project/machomebrew/mirror/cairo-1.12.14.tar.xz'
  sha256 '96d0d1e3f9b74d2ca3469ff187c5e5f25649b1ad35cf06f4f3a83847dff4ac13'

  keg_only :provided_pre_mountain_lion

  option :universal
  option 'without-x', 'Build without X11 support'

  depends_on 'staticfloat/juliadeps/pkg-config' => :build
  depends_on 'staticfloat/juliadeps/xz'=> :build
  # harfbuzz requires cairo-ft to build
  depends_on 'staticfloat/juliadeps/freetype' if build.without? 'x'
  depends_on 'staticfloat/juliadeps/libpng'
  depends_on 'staticfloat/juliadeps/pixman'
  depends_on 'staticfloat/juliadeps/glib' => :recommended
  depends_on :x11 if build.with? 'x'

  env :std if build.universal?

  bottle do
    root_url 'http://juliabottles.s3-website-us-east-1.amazonaws.com/bottles'
    cellar :any
    sha1 'f930ec561bdd30c9c9e6aadf993f6492e16eedc8' => :mountain_lion
    sha1 'f930ec561bdd30c9c9e6aadf993f6492e16eedc8' => :lion
    sha1 'f930ec561bdd30c9c9e6aadf993f6492e16eedc8' => :snow_leopard
  end

  def install
    ENV.universal_binary if build.universal?

    args = %W[
      --disable-dependency-tracking
      --prefix=#{prefix}
    ]

    if build.without? 'x'
      args << '--enable-xlib=no' << '--enable-xlib-xrender=no'
    else
      args << '--with-x'
    end

    if build.with? 'glib'
      args << '--enable-gobject=yes'
    else
      args << '--enable-gobject=no'
    end

    args << '--enable-xcb=no' if MacOS.version <= :leopard

    system "./configure", *args
    system "make install"
  end
end
