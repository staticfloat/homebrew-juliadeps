require 'formula'

class Gtkx3 < Formula
  homepage 'http://gtk.org/'
  url 'https://download.gnome.org/sources/gtk+/3.19/gtk+-3.19.1.tar.xz'
  sha256 'cd87b47a6f6436f16f15ebc1f0cbb113c92c603f572f920235405faaadc7bed9'

  bottle do
    root_url 'https://juliabottles.s3.amazonaws.com'
    cellar :any
    sha256 "b3f3d39d585116ecc000ad153afa32bf6fee9b10540faf2736d3629c48dcd172" => :mavericks
    sha256 "3973f23b9db563c3ddb2da85d9bb6fde7b14d2f566a6701daa8c63faaf0ad9ae" => :yosemite
    sha256 "a62747dd7cb31b39c45feb8490d53734a9b18ad800780ab7954fdbc98538a0b8" => :el_capitan
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
  depends_on 'staticfloat/juliadeps/gnome-icon-theme'
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
