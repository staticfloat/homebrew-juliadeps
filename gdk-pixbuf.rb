require 'formula'

class GdkPixbuf < Formula
  homepage 'http://gtk.org'
  url 'http://ftp.acc.umu.se/pub/GNOME/sources/gdk-pixbuf/2.33/gdk-pixbuf-2.33.1.tar.xz'
  sha256 '132358b39bd8204e2ef0571c14206dfdca1f44bcc94c21751d6e6b0433b5088b'
  revision 1

  bottle do
    root_url 'https://juliabottles.s3.amazonaws.com'
    cellar :any
    sha256 "269ca2ba97733f0da5e5f905a2bc3bcc1adb284b48993dd88a64152d186a7e51" => :mavericks
    sha256 "b74046ea7ae265a0d5cf497897b7a6feb21acdf136263fe41b6c419745eb3dc4" => :yosemite
    sha256 "f5f260a970022fd9cbc81b64f2e8781f02a8ce638afa82c0ebdc3e6161861a2e" => :el_capitan
  end

  option :universal

  depends_on "staticfloat/juliadeps/pkg-config" => :build
  depends_on "staticfloat/juliadeps/glib"
  depends_on "jpeg"
  depends_on "libtiff"
  depends_on "libpng"
  depends_on "staticfloat/juliadeps/gobject-introspection"

  # 'loaders.cache' must be writable by other packages
  skip_clean 'lib/gdk-pixbuf-2.0'

  def install
    ENV.universal_binary if build.universal?
    system "./configure", "--disable-dependency-tracking",
                          "--disable-maintainer-mode",
                          "--enable-debug=no",
                          "--prefix=#{prefix}",
                          "--enable-introspection=yes",
                          "--disable-Bsymbolic",
                          "--without-gdiplus"
    system "make"
    system "make", "install"

    # Other packages should use the top-level modules directory
    # rather than dumping their files into the gdk-pixbuf keg.
    inreplace lib/'pkgconfig/gdk-pixbuf-2.0.pc' do |s|
      libv = s.get_make_var 'gdk_pixbuf_binary_version'
      s.change_make_var! 'gdk_pixbuf_binarydir',
        HOMEBREW_PREFIX/'lib/gdk-pixbuf-2.0'/libv
    end
  end

  def post_install
    # Change the version directory below with any future update
    ENV["GDK_PIXBUF_MODULEDIR"]="#{HOMEBREW_PREFIX}/lib/gdk-pixbuf-2.0/#{version}/loaders"
    ENV["GDK_PIXBUF_MODULE_FILE"]="#{lib}/gdk-pixbuf-2.0/#{version}/loaders.cache"
    system "#{bin}/gdk-pixbuf-query-loaders", "--update-cache"
  end

  def caveats; <<-EOS.undent
    Programs that require this module need to set the environment variables
      export GDK_PIXBUF_MODULEDIR="#{HOMEBREW_PREFIX}/lib/gdk-pixbuf-2.0/#{version}/loaders"
      export GDK_PIXBUF_MODULE_FILE="#{HOMEBREW_PREFIX}/lib/gdk-pixbuf-2.0/#{version}/loaders.cache"
    If you need to manually update the query loader cache
      #{bin}/gdk-pixbuf-query-loaders --update-cache
    EOS
  end
end
