require "formula"

class Ecos < Formula
  homepage 'https://github.com/ifa-ethz/ecos'
  url 'https://github.com/embotech/ecos/archive/v2.0.4.tar.gz'
  head 'https://github.com/ifa-ethz/ecos.git'
  sha256 '07d467476b41ed9ec436ec894c4a2f1f5ee9100eeb8f18126bb84d5a2de2d795'

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
