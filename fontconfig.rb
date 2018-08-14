class Fontconfig < Formula
  desc "XML-based font configuration API for X Windows"
  homepage "https://wiki.freedesktop.org/www/Software/fontconfig/"
  url "https://www.freedesktop.org/software/fontconfig/release/fontconfig-2.13.0.tar.bz2"
  sha256 "91dde8492155b7f34bb95079e79be92f1df353fcc682c19be90762fd3e12eeb9"

  bottle do
    root_url "https://homebrew.bintray.com/bottles"
    cellar :any
    sha256 "8c9ff65654be03a4003d0e0d9e27fa1f03641aceadebd0f2a1b2f66cc1c2b54a" => :high_sierra
    sha256 "cfa65615f05fe6e0547be2738bed94d21f05491df2edf1e246da8a3669225e4d" => :sierra
    sha256 "664c8faf84a8bd6e80ebd8ca175c8e0a4cb6087f867e208cea4d9f8cda643134" => :el_capitan
  end

  depends_on "pkg-config" => :build
  depends_on "freetype"

  def install
    font_dirs = %w[
      /System/Library/Fonts
      /Library/Fonts
      ~/Library/Fonts
    ]

    if MacOS.version == :sierra
      font_dirs << "/System/Library/Assets/com_apple_MobileAsset_Font3"
    elsif MacOS.version == :high_sierra
      font_dirs << "/System/Library/Assets/com_apple_MobileAsset_Font4"
    end

    system "autoreconf", "-iv" if build.head?
    system "./configure", "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--enable-static",
                          "--with-add-fonts=#{font_dirs.join(",")}",
                          "--prefix=#{prefix}",
                          "--localstatedir=#{var}",
                          "--sysconfdir=#{etc}"
    system "make", "install", "RUN_FC_CACHE_TEST=false"
  end

  def post_install
    ohai "Regenerating font cache, this may take a while"
    system "#{bin}/fc-cache -frv"
  end

  test do
    system "#{bin}/fc-list"
  end
end
