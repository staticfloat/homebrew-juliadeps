# We are using the mainline formula here, EXCEPT FOR THE DEPS!

class GobjectIntrospection < Formula
  desc 'Generate interface introspection data for GObject libraries'
  homepage 'https://live.gnome.org/GObjectIntrospection'
  url 'https://download.gnome.org/sources/gobject-introspection/1.46/gobject-introspection-1.46.0.tar.xz'
  sha256 '6658bd3c2b8813eb3e2511ee153238d09ace9d309e4574af27443d87423e4233'

  bottle do
    root_url 'https://juliabottles.s3.amazonaws.com'
    cellar :any
    sha256 "9e29cdf8729bed7cba6d8098731d794b4330e333ab582a36c570890da7dd6983" => :mavericks
    sha256 "b401dd7220479654fb66b9df56168ef1062919f339f65a0a98e9c653b437dc3d" => :yosemite
    sha256 "a87abf73da8de680219811431254ca05fbff113c41a260ddb7c948a4a0408bf3" => :el_capitan
  end

  option :universal

  depends_on "staticfloat/juliadeps/pkg-config" => :run
  depends_on "staticfloat/juliadeps/glib"
  depends_on "libffi"

  resource "tutorial" do
    url "https://gist.github.com/7a0023656ccfe309337a.git",
        :revision => "499ac89f8a9ad17d250e907f74912159ea216416"
  end

  def install
    ENV["GI_SCANNER_DISABLE_CACHE"] = "true"
    ENV.universal_binary if build.universal?
    inreplace "giscanner/transformer.py", "/usr/share", "#{HOMEBREW_PREFIX}/share"
    inreplace "configure" do |s|
      s.change_make_var! "GOBJECT_INTROSPECTION_LIBDIR", "#{HOMEBREW_PREFIX}/lib"
    end

    system "./configure", "--disable-dependency-tracking", "--prefix=#{prefix}"
    system "make"
    system "make", "install"
  end

  test do
    ENV.prepend_path "PKG_CONFIG_PATH", Formula["libffi"].opt_lib/"pkgconfig"
    resource("tutorial").stage testpath
    system "make"
    assert (testpath/"Tut-0.1.typelib").exist?
  end
end
