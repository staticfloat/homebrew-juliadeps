require "formula"

class Ecos < Formula
  homepage 'https://github.com/ifa-ethz/ecos'
  url 'https://github.com/embotech/ecos/archive/v2.0.5.tar.gz'
  head 'https://github.com/ifa-ethz/ecos.git'
  sha256 '14c6ef81dfe9dad6af353e3499ad3a7a0eb1ebd289a995b038e3bc67c6101151'

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
