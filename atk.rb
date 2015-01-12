require 'formula'

class Atk < Formula
  homepage 'http://library.gnome.org/devel/atk/'
  url "http://ftp.gnome.org/pub/gnome/sources/atk/2.14/atk-2.14.0.tar.xz"
  sha256 "2875cc0b32bfb173c066c22a337f79793e0c99d2cc5e81c4dac0d5a523b8fbad"

  bottle do
    root_url 'https://juliabottles.s3.amazonaws.com'
    cellar :any
    sha1 "4f443152b4d70f54915cc5fb40b25f5c96d481e7" => :mountain_lion
    sha1 "c9131aa8b9ec4332d41b568a577374719f4e89a6" => :mavericks
    sha1 "5057b7eb46f80a53b86d243a95e67920145eb659" => :yosemite
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
