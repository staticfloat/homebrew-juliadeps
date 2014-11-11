require 'formula'

class Fontconfig < Formula
  homepage 'http://fontconfig.org/'
  url 'http://fontconfig.org/release/fontconfig-2.11.1.tar.bz2'
  sha1 '08565feea5a4e6375f9d8a7435dac04e52620ff2'

  bottle do
    root_url 'https://juliabottles.s3.amazonaws.com'
    cellar :any
    sha1 '8350de16baf1ae81f315935ea2037206fbd09aed' => :lion
    sha1 '19898a3e5251c1d2c60643ef5f26ba7752784afa' => :mavericks
    sha1 'f24b070d413a0286933774c3c9ce585c68250b32' => :mountain_lion
    sha1 "db3b142705fcdab542caf1f460446b45747a7d2c" => :yosemite
  end

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
    return true
  end
end
