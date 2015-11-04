require "formula"

class Gettext < Formula
  homepage 'https://www.gnu.org/software/gettext/'
  url 'http://ftpmirror.gnu.org/gettext/gettext-0.19.6.tar.xz'
  mirror 'https://ftp.gnu.org/gnu/gettext/gettext-0.19.6.tar.xz'

  bottle do
    root_url 'https://juliabottles.s3.amazonaws.com'
    cellar :any
    sha256 "45d0f862b12be54543eb7d018d62af835d40924f5d3331cfb3e1620e60270cd3" => :mavericks
    sha256 "5166e1af01f75495fffbdaebc999af462a3d2dbafdb9abcc10fd3b7089b49823" => :yosemite
    sha256 "034b83e08a6c61f806b5f660cd8a6df96e850ba5b1ebd709718cfdd43f2bb5e5" => :el_capitan
  end

  option :universal

  def install
    ENV.libxml2
    ENV.universal_binary if build.universal?

    system "./configure", "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--disable-debug",
                          "--prefix=#{prefix}",
                          "--with-included-gettext",
                          "--with-included-glib",
                          "--with-included-libcroco",
                          "--with-included-libunistring",
                          "--with-emacs",
                          "--disable-java",
                          "--disable-csharp",
                          # Don't use VCS systems to create these archives
                          "--without-git",
                          "--without-cvs",
                          "--without-xz"
    system "make"
    ENV.deparallelize # install doesn't support multiple make jobs
    system "make", "install"
  end

  test do
    system "#{bin}/gettext", "test"
  end
end
