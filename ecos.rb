require "formula"

class Ecos < Formula
  homepage 'https://github.com/ifa-ethz/ecos'
  url 'https://github.com/embotech/ecos/archive/v2.0.4.tar.gz'
  head 'https://github.com/ifa-ethz/ecos.git'
  sha256 '07d467476b41ed9ec436ec894c4a2f1f5ee9100eeb8f18126bb84d5a2de2d795'

  bottle do
    root_url 'https://juliabottles.s3.amazonaws.com'
    cellar :any
    sha256 "8320143cfd5790a67a3d8eff601cd12362137763eb8dac3022677b1c1ee0783c" => :mavericks
    sha256 "b9ad1bd609a23d104ef834b27997f5177fe333faa65272ae6ddc9d837915762d" => :yosemite
    sha256 "2831946f7d4d12f9c62f2e2b337a69cb2b65913a99ee31b3a73b962f3741dd8e" => :el_capitan
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
