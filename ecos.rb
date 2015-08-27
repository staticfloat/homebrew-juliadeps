require "formula"

class Ecos < Formula
  homepage "https://github.com/ifa-ethz/ecos"
  url "https://github.com/embotech/ecos/archive/v2.0.2.tar.gz"
  head "https://github.com/ifa-ethz/ecos.git"
  sha256 "331ac641a4ded00bc9de00412a025f707355efc9fcb34ab6a051383fd0149998"

  bottle do
    root_url 'https://juliabottles.s3.amazonaws.com'
    cellar :any
    sha256 "cf0b92bd9f3327949fa3e4b20fc64bd7066ac2f9340b35eabd8e0ee7c169d44c" => :yosemite
    sha256 "6a207648ce79469715680ce77ec9ae2d617ee15371519aab3e32b14ee1844385" => :mavericks
    sha256 "45bc2c9c69a84488d9bc566c01d55e6f408e5c932b867ad564f0f1b2ffccb566" => :mountain_lion
  end

  def install
    system "make", "shared"
    system "make", "test"

    # Install the real goodies
    lib.install "libecos.a", "libecos.dylib"

    # Install header files to <prefix>/include/ecos
    include.install "include"
    mv "#{include}/include", "#{include}/ecos"

    # Install ecostester so we can test installation afterward!
    bin.install "ecostester"
  end

  test do
    system "#{bin}/ecostester"
  end
end
