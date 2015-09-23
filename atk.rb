require 'formula'

class Atk < Formula
  desc "GNOME accessibility toolkit"
  homepage 'http://library.gnome.org/devel/atk/'
  url "https://download.gnome.org/sources/atk/2.16/atk-2.16.0.tar.xz"
  sha256 "095f986060a6a0b22eb15eef84ae9f14a1cf8082488faa6886d94c37438ae562"

  bottle do
    root_url 'https://juliabottles.s3.amazonaws.com'
    cellar :any
  end

  depends_on 'staticfloat/juliadeps/pkg-config' => :build
  depends_on 'staticfloat/juliadeps/glib'
  depends_on 'gobject-introspection'

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
