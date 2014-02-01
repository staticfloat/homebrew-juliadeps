require 'formula'

class Harfbuzz < Formula
  homepage 'http://www.freedesktop.org/wiki/Software/HarfBuzz'
  url 'http://www.freedesktop.org/software/harfbuzz/release/harfbuzz-0.9.21.tar.bz2'
  sha256 'a0d36f883d98f2375f9b2a03c8a6c361b161a76d4b58ea9d08be59e39e73dae8'

  depends_on 'staticfloat/juliadeps/pkg-config' => :build
  depends_on 'staticfloat/juliadeps/glib'
  depends_on 'staticfloat/juliadeps/cairo'
  depends_on 'freetype'

  bottle do
    root_url 'http://archive.org/download/julialang/bottles'
    cellar :any
    revision 1
    sha1 '51134b8442512cb1d2131010c26980b5f2804cce' => :snow_leopard_or_later
  end

  # Needs newer fontconfig than XQuartz provides for pango
  depends_on 'staticfloat/juliadeps/fontconfig'

  def install
    system "./configure", "--disable-dependency-tracking", "--prefix=#{prefix}"
    system "make install"
  end
end
