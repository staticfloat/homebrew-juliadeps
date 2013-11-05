require 'formula'

class Freetype < Formula
  homepage 'http://www.freetype.org'
  url 'http://downloads.sf.net/project/freetype/freetype2/2.5.0/freetype-2.5.0.1.tar.gz'
  sha1 '2d539b375688466a8e7dcc4260ab21003faab08c'

  bottle do
    root_url 'http://archive.org/download/julialang/bottles'
    cellar :any
    sha1 'dadd3adf072bb61d4aec0ee102fc8113177dcd9e' => :mountain_lion
    sha1 'dadd3adf072bb61d4aec0ee102fc8113177dcd9e' => :lion
    sha1 'dadd3adf072bb61d4aec0ee102fc8113177dcd9e' => :snow_leopard
    sha1 'dadd3adf072bb61d4aec0ee102fc8113177dcd9e' => :mavericks
  end

  option :universal
  depends_on 'staticfloat/juliadeps/libpng'

  def install
    ENV.universal_binary if build.universal?
    system "./configure", "--prefix=#{prefix}"
    system "make"
    system "make install"
  end

  test do
    system "#{bin}/freetype-config", '--cflags', '--libs', '--ftversion',
      '--exec-prefix', '--prefix'
  end
end
