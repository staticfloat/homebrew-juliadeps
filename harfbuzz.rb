require 'formula'

class Harfbuzz < Formula
  homepage 'http://www.freedesktop.org/wiki/Software/HarfBuzz'
  url 'http://www.freedesktop.org/software/harfbuzz/release/harfbuzz-0.9.21.tar.bz2'
  sha256 'a0d36f883d98f2375f9b2a03c8a6c361b161a76d4b58ea9d08be59e39e73dae8'

  depends_on 'staticfloat/juliadeps/pkg-config' => :build
  depends_on 'staticfloat/juliadeps/glib'
  depends_on 'staticfloat/juliadeps/cairo'
  depends_on 'staticfloat/juliadeps/freetype'

  bottle do
    root_url 'http://archive.org/download/julialang/bottles'
    cellar :any
    sha1 'fe15631d4d5b0e723d8218f73f3609586305c437' => :mavericks
    sha1 'fe15631d4d5b0e723d8218f73f3609586305c437' => :mountain_lion
    sha1 'fe15631d4d5b0e723d8218f73f3609586305c437' => :lion
    sha1 'fe15631d4d5b0e723d8218f73f3609586305c437' => :snow_leopard
  end

  # Needs newer fontconfig than XQuartz provides for pango
  depends_on 'staticfloat/juliadeps/fontconfig'

  def install
    system "./configure", "--disable-dependency-tracking", "--prefix=#{prefix}"
    system "make install"
  end
end
