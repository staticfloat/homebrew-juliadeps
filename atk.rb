require 'formula'

class Atk < Formula
  desc "GNOME accessibility toolkit"
  homepage 'http://library.gnome.org/devel/atk/'
  url "https://download.gnome.org/sources/atk/2.16/atk-2.16.0.tar.xz"
  sha256 "095f986060a6a0b22eb15eef84ae9f14a1cf8082488faa6886d94c37438ae562"

  bottle do
    root_url 'https://juliabottles.s3.amazonaws.com'
    cellar :any
    sha256 "3d1fac6d50e12d5f0337b9849035afd2abadb4d4438894495ae01ce2c2df1ce2" => :mavericks
    sha256 "26381cb8d5aa0958c84ffd2803d419953369af6a57ea5d41b46ce471e6efb4f8" => :mountain_lion
    sha256 "bff491c7eb8c6de9fff1717f2af281cf7a4e0a72d9c597d9e7c4945e3a6f6abf" => :yosemite
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
