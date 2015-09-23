require 'formula'

class GdkPixbuf < Formula
  homepage 'http://gtk.org'
  url 'http://ftp.gnome.org/pub/GNOME/sources/gdk-pixbuf/2.30/gdk-pixbuf-2.30.8.tar.xz'
  sha256 '4853830616113db4435837992c0aebd94cbb993c44dc55063cee7f72a7bef8be'
  revision 1

  bottle do
    root_url 'https://juliabottles.s3.amazonaws.com'
    cellar :any
    sha256 "8760c5d014b4a51fdb432723164bf9b6a1a959e0330386ae5f68351d733a0c97" => :yosemite
    sha256 "cc1e387779eb18cff7154988d4abad845cf3c85afc201f673eccd7caeddfb78d" => :mavericks
    sha256 "f41eeb44906fecf8e23455328497b5eef9b47d41953b45cb7be9fc4c172a5f5d" => :mountain_lion
  end

  option :universal

  depends_on "staticfloat/juliadeps/pkg-config" => :build
  depends_on "staticfloat/juliadeps/glib"
  depends_on "jpeg"
  depends_on "libtiff"
  depends_on "libpng"
  depends_on "gobject-introspection"

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
    ENV["GDK_PIXBUF_MODULEDIR"]="#{HOMEBREW_PREFIX}/lib/gdk-pixbuf-2.0/2.10.0/loaders"
    ENV["GDK_PIXBUF_MODULE_FILE"]="#{lib}/gdk-pixbuf-2.0/2.10.0/loaders.cache"
    system "#{bin}/gdk-pixbuf-query-loaders", "--update-cache"
  end

  def caveats; <<-EOS.undent
    Programs that require this module need to set the environment variables
      export GDK_PIXBUF_MODULEDIR="#{HOMEBREW_PREFIX}/lib/gdk-pixbuf-2.0/2.10.0/loaders"
      export GDK_PIXBUF_MODULE_FILE="#{HOMEBREW_PREFIX}/lib/gdk-pixbuf-2.0/2.10.0/loaders.cache"
    If you need to manually update the query loader cache
      #{bin}/gdk-pixbuf-query-loaders --update-cache
    EOS
  end
end
