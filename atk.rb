require 'formula'

class Atk < Formula
  desc "GNOME accessibility toolkit"
  homepage 'http://library.gnome.org/devel/atk/'
  url "https://download.gnome.org/sources/atk/2.18/atk-2.18.0.tar.xz"

  bottle do
    root_url 'https://juliabottles.s3.amazonaws.com'
    cellar :any
  end

  depends_on 'staticfloat/juliadeps/pkg-config' => :build
  depends_on 'staticfloat/juliadeps/glib'
  depends_on 'staticfloat/juliadeps/gobject-introspection'

  option :universal

  def install
    ENV.universal_binary if build.universal?
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--enable-introspection=yes"
    system "make"
    system "make install"
  end
end
