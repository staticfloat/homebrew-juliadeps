require 'formula'

class Gettext < Formula
  homepage 'http://www.gnu.org/software/gettext/'
  url 'http://ftpmirror.gnu.org/gettext/gettext-0.18.3.1.tar.gz'
  mirror 'http://ftp.gnu.org/gnu/gettext/gettext-0.18.3.1.tar.gz'
  sha256 '0d8f9a33531b77776b3dc473e7940019ca19bfca5b4c06db6e96065eeb07245d'

  bottle do
    root_url 'http://juliabottles.s3-website-us-east-1.amazonaws.com/bottles'
    cellar :any
    revision 1
    sha1 'f8a5318e40edacf30e7985d5097ec415a0a997a1' => :mountain_lion
    sha1 'f8a5318e40edacf30e7985d5097ec415a0a997a1' => :lion
    sha1 'f8a5318e40edacf30e7985d5097ec415a0a997a1' => :snow_leopard
  end

  option :universal
  option 'with-examples', 'Keep example files'

  def patches
    unless build.include? 'with-examples'
      # Use a MacPorts patch to disable building examples at all,
      # rather than build them and remove them afterwards.
      {:p0 => ['https://trac.macports.org/export/102008/trunk/dports/devel/gettext/files/patch-gettext-tools-Makefile.in']}
    end
  end

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
