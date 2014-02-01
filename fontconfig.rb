require 'formula'

class Fontconfig < Formula
  homepage 'http://fontconfig.org/'
  url 'http://fontconfig.org/release/fontconfig-2.10.95.tar.bz2'
  sha1 'f9f4a25b730a9c56f951db6fec639ddeeb92a9d4'

  option :universal

  bottle do
    root_url 'http://archive.org/download/julialang/bottles'
    cellar :any
    revision 1
    sha1 'e647d640fc9d6745106bc6c42bed66ccf53fe573' => :snow_leopard_or_later
  end

  depends_on 'freetype'
  depends_on 'staticfloat/juliadeps/pkg-config' => :build

  def install
    ENV.universal_binary if build.universal?
    system "./configure", "--disable-dependency-tracking",
                          "--with-add-fonts=/Library/Fonts,~/Library/Fonts",
                          "--prefix=#{prefix}"
    system "make install"
  end
end
