class Fontconfig < Formula
  desc "XML-based font configuration API for X Windows"
  homepage "https://wiki.freedesktop.org/www/Software/fontconfig/"
  url "https://www.freedesktop.org/software/fontconfig/release/fontconfig-2.12.1.tar.bz2"
  sha256 "b449a3e10c47e1d1c7a6ec6e2016cca73d3bd68fbbd4f0ae5cc6b573f7d6c7f3"

  bottle do
    root_url "https://homebrew.bintray.com/bottles"
    cellar :any
    sha256 "297921c6444ba5f5bc0db5ed06b91fcc3185e0f6e457687623087eefa5e5926a" => :yosemite
    sha256 "1294efa738fe47f04bad7835c6ca2550e9149bf65380c155493904fd9b7f78e8" => :el_capitan
    sha256 "1cb9ef933a9092cded22a5094e234d0424f75fc77f90615cbc05c95eae607791" => :mavericks
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
