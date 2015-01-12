require 'formula'

class Gtkx3 < Formula
  homepage 'http://gtk.org/'
  url "http://ftp.gnome.org/pub/gnome/sources/gtk+/3.14/gtk+-3.14.6.tar.xz"
  sha256 "cfc424e6e10ffeb34a33762aeb77905c3ed938f0b4006ddb7e880aad234ef119"

  bottle do
    root_url 'https://juliabottles.s3.amazonaws.com'
    cellar :any
    sha1 "2bbeb6ec73d4340474fffbed642480e4f6803866" => :yosemite
    sha1 "fdf82f77cfb2a5839b721801f29773dc7134f5c2" => :mavericks
    sha1 "b00abf9b51fec6d86a66c2284d67c5bead9a44c5" => :mountain_lion
  end

  depends_on 'staticfloat/juliadeps/pkg-config' => :build
  depends_on 'xz' => :build
  depends_on 'staticfloat/juliadeps/glib'
  depends_on 'staticfloat/juliadeps/gobject-introspection'
  depends_on 'jpeg'
  depends_on 'libtiff'
  depends_on 'staticfloat/juliadeps/gdk-pixbuf'
  depends_on 'staticfloat/juliadeps/pango'
  depends_on 'staticfloat/juliadeps/cairo'
  depends_on 'staticfloat/juliadeps/atk'

  def install
    ENV.universal_binary if build.universal?

    args = %W[
      --disable-debug
      --disable-dependency-tracking
      --prefix=#{prefix}
      --disable-glibtest
      --enable-introspection=yes
      --disable-schemas-compile
      --enable-quartz-backend
      --enable-quartz-relocation
    ]

    system "./configure", *args
    system "make", "install"
    # Prevent a conflict between this and Gtk+2
    mv bin/"gtk-update-icon-cache", bin/"gtk3-update-icon-cache"
  end

  # Note that you need to define XDG_DATA_DIRS="#{HOMEBREW_PREFIX}/share" to use the schemas properly
  def post_install
    system "#{Formula["glib"].opt_bin}/glib-compile-schemas", "#{HOMEBREW_PREFIX}/share/glib-2.0/schemas"
  end
end
