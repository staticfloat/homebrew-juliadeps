require 'formula'

class Libpng < Formula
  homepage 'http://www.libpng.org/pub/png/libpng.html'
  url 'http://downloads.sf.net/project/libpng/libpng15/older-releases/1.5.14/libpng-1.5.14.tar.gz'
  sha1 '67f20d69564a4a50204cb924deab029f11ad2d3c'

  option :universal

  bottle do
    root_url 'http://archive.org/download/julialang/bottles'
    cellar :any
    revision 1
    sha1 '69bb26ca333d745b8223827a6c4758d2732873f6' => :mountain_lion
    sha1 '69bb26ca333d745b8223827a6c4758d2732873f6' => :lion
    sha1 '69bb26ca333d745b8223827a6c4758d2732873f6' => :snow_leopard
  end

  def install
    ENV.universal_binary if build.universal?
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make install"
  end
end
