require "formula"

class Ecos < Formula
  homepage "https://github.com/ifa-ethz/ecos"
  url "https://github.com/embotech/ecos/archive/v2.0.2.tar.gz"
  head "https://github.com/ifa-ethz/ecos.git"
  sha256 "331ac641a4ded00bc9de00412a025f707355efc9fcb34ab6a051383fd0149998"

  bottle do
    root_url 'https://juliabottles.s3.amazonaws.com'
    cellar :any
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
