require 'formula'

class Glpk461 < Formula
  homepage 'https://www.gnu.org/software/glpk/'
  url 'https://ftpmirror.gnu.org/glpk/glpk-4.61.tar.gz'
  mirror 'https://ftp.gnu.org/gnu/glpk/glpk-4.61.tar.gz'
  sha256 '9866de41777782d4ce21da11b88573b66bb7858574f89c28be6967ac22dfaba9'

  bottle do
    root_url 'https://juliabottles.s3.amazonaws.com'
    cellar :any
    sha256 "2a90938fda7150ad68b522130c9e77637922c0c4fc1fe2f9ce31161214a3a09f" => :mavericks
    sha256 "5f0d006468727f1e8cf244de36c0dd8656b31e0fd7fb3981c0d5443f8c5acb92" => :yosemite
    sha256 "5394c6d5d80c170fcb8124161801316a0534c43ac78842e64d18b9a89eb88a24" => :el_capitan
    sha256 "ff2e684a24b5858e3032e384f76e947b902550ad8ee5a0fbc3c211c20064a611" => :sierra
  end

  def install
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make install"
  end
end
