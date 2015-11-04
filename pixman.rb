require "formula"

class Pixman < Formula
  homepage 'http://cairographics.org/'
  url 'http://cairographics.org/releases/pixman-0.32.8.tar.gz'
  sha256 '575ade17c40b47d391b02b4c0c63531c897b31e70046c96749514b7d8800d65d'

  bottle do
    root_url 'https://juliabottles.s3.amazonaws.com'
    cellar :any
    sha256 "68eb4a28ea7b30ae232b10c53dff7d8d8cc3cb556705d5f047f42182e81246e8" => :mavericks
    sha256 "d8d04fe405352616d2fbad1df8d782de0654677a7faa1a1553fbc7b93f9dd6c1" => :yosemite
    sha256 "7e958967acf5f4ce7af14f397d7061fc5c93e0e19ae4a14bef0a9154ef221df2" => :el_capitan
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
