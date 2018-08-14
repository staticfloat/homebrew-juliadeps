class Fontconfig < Formula
  desc "XML-based font configuration API for X Windows"
  homepage "https://wiki.freedesktop.org/www/Software/fontconfig/"
  url "https://www.freedesktop.org/software/fontconfig/release/fontconfig-2.13.0.tar.bz2"
  sha256 "91dde8492155b7f34bb95079e79be92f1df353fcc682c19be90762fd3e12eeb9"

  bottle do
    root_url "https://homebrew.bintray.com/bottles"
    cellar :any
    sha256 "66ad096a51d6253be02b4d3df0299d422c8bd1bccf571ed64a8b8b21a2e77bc7" => :high_sierra
    sha256 "d822bc26c6b556606087e5807293492814fedf9d408c857006b0886608010400" => :sierra
    sha256 "a8016f2aff75677bab388a0ab138b4528d787c44c337f6ee7236e0de4a1cb268" => :el_capitan
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
