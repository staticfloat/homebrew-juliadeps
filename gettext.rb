require "formula"

class Gettext < Formula
  homepage "https://www.gnu.org/software/gettext/"
  url "http://ftpmirror.gnu.org/gettext/gettext-0.19.4.tar.xz"
  mirror "https://ftp.gnu.org/gnu/gettext/gettext-0.19.4.tar.xz"
  sha256 "719adadb8bf3e36bac52c243a01c0add18d23506a3a40437e6f5899ceab18d20"

  bottle do
    root_url 'https://juliabottles.s3.amazonaws.com'
    cellar :any
    sha1 "7508312673e0ee49444d14b55e4d3feaa72af7a4" => :mavericks
    sha1 "d2c78ec3eb8f83054f5e02652c44a03e3c1c4a5c" => :mountain_lion
    sha1 "a14136e5c8126567a4628e9ee1a4920e8ec276f9" => :yosemite
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
