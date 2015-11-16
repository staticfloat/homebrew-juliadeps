require "formula"

class Harfbuzz < Formula
  homepage 'http://www.freedesktop.org/wiki/Software/HarfBuzz'
  url 'http://www.freedesktop.org/software/harfbuzz/release/harfbuzz-0.9.42.tar.bz2'
  sha256 'c27240b6bdca7c497e5d0bebdb6d411cfcd4c1662815f3edbd8cc96246216ce2'

  bottle do
    root_url 'https://juliabottles.s3.amazonaws.com'
    cellar :any
    sha256 "d84f8329c29bc43a2e5f601c4bc4e5c1956d8b18327b2dab8097f8620efd7114" => :mavericks
    sha256 "8b93f9447f0cf27e0c78ac3236fb234d8137bce1dc9e37999da405ae39862dba" => :yosemite
    sha256 "fdc9ed3e17dcdfe9d1655c296b4d2c797dd89a5c48a95bfc88c7e1cbcdbf5d82" => :el_capitan
  end

  depends_on "staticfloat/juliadeps/pkg-config" => :build
  depends_on "staticfloat/juliadeps/glib"
  depends_on "staticfloat/juliadeps/cairo"
  depends_on "staticfloat/juliadeps/icu4c" => :recommended
  depends_on "freetype"

  def install
    args = %W[--disable-dependency-tracking --prefix=#{prefix}]
    args << "--with-icu" if build.with? "icu4c"
    system "./configure", *args
    system "make install"
  end
end
