require "formula"

class Ecos < Formula
  homepage 'https://github.com/ifa-ethz/ecos'
  url 'https://github.com/embotech/ecos/archive/v2.0.5.tar.gz'
  head 'https://github.com/ifa-ethz/ecos.git'
  sha256 '14c6ef81dfe9dad6af353e3499ad3a7a0eb1ebd289a995b038e3bc67c6101151'

  bottle do
    root_url 'https://juliabottles.s3.amazonaws.com'
    cellar :any
    sha256 "d72f245ec2decbd4803f484e8beac4a6dfd02d97d4001e15ea1c65232fe76ddb" => :mavericks
    sha256 "2c78a18c209fe1f78176f1250386f39313dbc63000be224376acc25ee828defc" => :el_capitan
    sha256 "9984135adb3e015a5294a9e9b769e26ff718f0a3b9c98a2870b7b03c1247958b" => :yosemite
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
