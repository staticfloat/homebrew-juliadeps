require 'formula'

class Fontconfig < Formula
  homepage 'http://fontconfig.org/'
  url 'http://fontconfig.org/release/fontconfig-2.11.1.tar.bz2'
  sha1 '08565feea5a4e6375f9d8a7435dac04e52620ff2'

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
