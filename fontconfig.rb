require 'formula'

class Fontconfig < Formula
  homepage 'http://fontconfig.org/'
  url 'http://fontconfig.org/release/fontconfig-2.11.0.tar.bz2'
  sha1 '969818b0326ac08241b11cbeaa4f203699f9b550'

  option :universal

  depends_on 'freetype'
  depends_on 'staticfloat/juliadeps/pkg-config' => :build

  def install
    ENV.universal_binary if build.universal?
    system "./configure", "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--with-add-fonts=/System/Library/Fonts,/Library/Fonts,~/Library/Fonts",
                          "--prefix=#{prefix}",
                          "--localstatedir=#{var}",
                          "--sysconfdir=#{etc}"
    system "make install"
  end

  def post_install
    system "#{bin}/fc-cache", "-frv"
  end
end
