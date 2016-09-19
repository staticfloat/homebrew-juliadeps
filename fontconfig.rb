class Fontconfig < Formula
  desc "XML-based font configuration API for X Windows"
  homepage "https://wiki.freedesktop.org/www/Software/fontconfig/"
  url "https://www.freedesktop.org/software/fontconfig/release/fontconfig-2.12.1.tar.bz2"
  sha256 "b449a3e10c47e1d1c7a6ec6e2016cca73d3bd68fbbd4f0ae5cc6b573f7d6c7f3"
  revision 4

  bottle do
    root_url "https://homebrew.bintray.com/bottles"
    cellar :any
    sha256 "6c1bf06d44c732a3304b4b8c39511e336fcce9e4255c59b250e18b63e30fe660" => :el_capitan
    sha256 "a643c5596ef3e7c11d46d0cf8766f1e8a6e16dfedef55f0e14a2094d2e6bd3f0" => :yosemite
    sha256 "217ed41407f0027afac6f1b3e6748ca51fb45e60168d0ee2b86c8ce1093ee7c2" => :mavericks
  end

  keg_only :provided_pre_mountain_lion

  option :universal

  depends_on "pkg-config" => :build
  depends_on "freetype"

  def install
    ENV.universal_binary if build.universal?
    system "./configure", "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--enable-static",
                          "--with-add-fonts=/System/Library/Fonts,/Library/Fonts,~/Library/Fonts",
                          "--prefix=#{prefix}",
                          "--localstatedir=#{var}",
                          "--sysconfdir=#{etc}"
    system "make", "install", "RUN_FC_CACHE_TEST=false"
  end

  def post_install
    ohai "Regenerating font cache, this may take a while"
    system "#{bin}/fc-cache", "-frv"
  end

  test do
    system "#{bin}/fc-list"
  end
end
