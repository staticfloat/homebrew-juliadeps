require 'formula'

class Gtkx3 < Formula
  homepage 'http://gtk.org/'
  url 'http://ftp.gnome.org/pub/gnome/sources/gtk+/3.12/gtk+-3.12.2.tar.xz'
  sha256 '61d74eea74231b1ea4b53084a9d6fc9917ab0e1d71b69d92cbf60a4b4fb385d0'

  bottle do
    root_url 'https://juliabottles.s3.amazonaws.com'
    cellar :any
    sha1 '57cd2669d5014e02088933730095bdc57c50e102' => :lion
    sha1 '6e48aa8641f4b1fa8663fe3fa3c41a4f387965fa' => :mavericks
    sha1 '55e40b86d75c0deb764787babad42ca775968df3' => :mountain_lion
  end

  depends_on 'staticfloat/juliadeps/pkg-config' => :build
  depends_on 'xz' => :build
  depends_on 'staticfloat/juliadeps/glib'
  depends_on 'jpeg'
  depends_on 'libtiff'
  depends_on 'staticfloat/juliadeps/gdk-pixbuf'
  depends_on 'staticfloat/juliadeps/pango'
  depends_on 'staticfloat/juliadeps/cairo'
  depends_on 'staticfloat/juliadeps/atk'

  def install
    # gtk-update-icon-cache is used during installation, and
    # we don't want to add a dependency on gtk+2 just for this.
    inreplace %w[ gtk/makefile.msc.in
                  demos/gtk-demo/Makefile.in
                  demos/widget-factory/Makefile.in ],
                  /gtk-update-icon-cache --(force|ignore-theme-index)/,
                  "#{buildpath}/gtk/\\0"

    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--disable-glibtest",
                          "--enable-quartz-backend",
                          "--disable-x11-backend",
                          "--enable-introspection=yes",
                          "--disable-schemas-compile"
    system "make install"
    # Prevent a conflict between this and Gtk+2
    mv bin/'gtk-update-icon-cache', bin/'gtk3-update-icon-cache'
  end

  # Note that you need to define XDG_DATA_DIRS="#{HOMEBREW_PREFIX}/share" to use the schemas properly
  def post_install
    system "#{HOMEBREW_PREFIX}/bin/glib-compile-schemas", "#{HOMEBREW_PREFIX}/share/glib-2.0/schemas"
  end
end
