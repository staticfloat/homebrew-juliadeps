require "formula"

class Ecos < Formula
  homepage "https://github.com/ifa-ethz/ecos"
  url "https://github.com/ifa-ethz/ecos/archive/d206a556a83396756f3200964de162b4a7523c62.tar.gz"
  head "https://github.com/ifa-ethz/ecos.git"
  sha1 "a43e64a72d803c45d2e8f69ed2f0fbfcc368692f"
  version "1.0.4.1"

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
