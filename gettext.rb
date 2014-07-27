require "formula"

class Gettext < Formula
  homepage "https://www.gnu.org/software/gettext/"
  url "http://ftpmirror.gnu.org/gettext/gettext-0.19.2.tar.xz"
  mirror "https://ftp.gnu.org/gnu/gettext/gettext-0.19.2.tar.xz"
  sha256 "b34e1baaf37e56b4f5d7104353a437a735b2e094a70588e7c5ae671eaa0819c3"
  revision 1

  bottle do
    root_url 'https://juliabottles.s3.amazonaws.com'
    cellar :any
    revision 1
    sha1 'e25501a54b72d3354233e051e05906621606a57c' => :lion
    sha1 'db224b65da43c3323da7da5fce307b7c8c2e034f' => :mavericks
    sha1 'f5d1f5724e2e9926af99e86af79b18de7d009128' => :mountain_lion
  end

  option :universal

  def install
    ENV.libxml2
    ENV.universal_binary if build.universal?

    system "./configure", "--disable-dependency-tracking",
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
                          "--without-cvs"
    system "make"
    ENV.deparallelize # install doesn't support multiple make jobs
    system "make install"
  end
end
