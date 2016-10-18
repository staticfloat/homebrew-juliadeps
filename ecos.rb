require "formula"

class Ecos < Formula
  homepage 'https://github.com/ifa-ethz/ecos'
  url 'https://github.com/embotech/ecos/archive/v2.0.5.tar.gz'
  head 'https://github.com/ifa-ethz/ecos.git'
  sha256 '14c6ef81dfe9dad6af353e3499ad3a7a0eb1ebd289a995b038e3bc67c6101151'

  bottle do
    root_url 'https://juliabottles.s3.amazonaws.com'
    cellar :any
    rebuild 1
    sha256 "484c5c3979936414d8d37d275270086e329f2233c7d5456e1fcf38a0de43cdad" => :mavericks
    sha256 "10a8ef75331eabd767f2349a5211c73723ffa586fa987b7e981d1c84e0ed8dca" => :yosemite
    sha256 "ae6869666e75dc12f94d3eacdb6a6af12adb3f59172fac195318f88132b8d395" => :el_capitan
    sha256 "3e2263d40f1124e5d40664d2c8ac2e4d440ba344ab8e83547fb9266ad6ce5816" => :sierra
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
