require 'formula'

class Gtkx3 < Formula
  homepage 'http://gtk.org/'
  url "https://download.gnome.org/sources/gtk+/3.16/gtk+-3.16.6.tar.xz"
  sha256 "4d12726d0856a968b41802ae5c5971d7e9bac532717e309d3f81b9989da5ffbe"

  bottle do
    root_url 'https://juliabottles.s3.amazonaws.com'
    cellar :any
    sha256 "fd13958a60a0506743efe9aba7f01e82826ba36210911de4a581b9137cde0c4a" => :mountain_lion
    sha256 "976ccd76850e37a9165624875a27e4acd57815c2d29ab0f28d5ba868efa8bdd7" => :yosemite
    sha256 "d5b1aea73ddb9476f73726182af72a0f064699a4e1611f0d1866bd86b4e32eba" => :mavericks
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
  depends_on 'hicolor-icon-theme'
  depends_on 'gnome-icon-theme'
  depends_on 'staticfloat/juliadeps/libepoxy'

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
      --disable-x11-backend
    ]

    system "./configure", *args
    # necessary to avoid gtk-update-icon-cache not being found during make install
    bin.mkpath
    ENV.prepend_path "PATH", "#{bin}"
    system "make", "install"
    # Prevent a conflict between this and Gtk+2
    mv bin/"gtk-update-icon-cache", bin/"gtk3-update-icon-cache"
  end

  def post_install
    system "#{Formula["glib"].opt_bin}/glib-compile-schemas", "#{HOMEBREW_PREFIX}/share/glib-2.0/schemas"
  end
end
