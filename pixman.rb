require "formula"

class Pixman < Formula
  homepage 'http://cairographics.org/'
  url 'http://cairographics.org/releases/pixman-0.32.8.tar.gz'
  sha256 '575ade17c40b47d391b02b4c0c63531c897b31e70046c96749514b7d8800d65d'

  bottle do
    root_url 'https://juliabottles.s3.amazonaws.com'
    cellar :any
    revision 1
    sha256 "506660e1c0f11b2fa38e82feb4dbf86dcee124e9fd2fbc2e68fba7aaa359b51a" => :mavericks
    sha256 "c7048174f8886a3c7df2dd9a9f78e0b1810bcbe451f602901eb2c7125bc30d7a" => :yosemite
    sha256 "5819731c649e29ec89f33a39f2643f6e5158faf0085f7c85246267cb985701bb" => :el_capitan
  end

  depends_on "staticfloat/juliadeps/pkg-config" => :build

  keg_only :provided_pre_mountain_lion

  option :universal

  fails_with :llvm do
    build 2336
    cause <<-EOS.undent
      Building with llvm-gcc causes PDF rendering issues in Cairo.
      https://trac.macports.org/ticket/30370
      See Homebrew issues #6631, #7140, #7463, #7523.
      EOS
  end

  def install
    ENV.universal_binary if build.universal?

    system "./configure", "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}",
                          "--disable-mmx", # MMX assembler fails with Xcode 7 / osx El Capitan
                          "--disable-gtk"
    system "make", "install"
  end
end
