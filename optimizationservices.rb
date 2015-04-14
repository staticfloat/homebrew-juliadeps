require 'formula'

class Optimizationservices < Formula
  homepage 'https://projects.coin-or.org/OS'
  url 'http://www.coin-or.org/download/pkgsource/OS/OS-2.9.2.tgz'
  sha1 '90340631a5ce7fa05a67484d624d1692473e9763'

  depends_on 'staticfloat/juliadeps/pkg-config' => :build
  depends_on 'staticfloat/juliadeps/couenne'
  depends_on 'homebrew/science/cppad' => :build

  bottle do
    root_url 'https://juliabottles.s3.amazonaws.com'
    cellar :any
    sha256 "939e7d3a5d990cb5b14d840f414f7b1b76155474bd9e5b6079c311b6590e2f29" => :mavericks
    sha256 "9349c42d184cb80bcb1566d2def3e325d2b6a7b85af8eeb8430cf60719e21654" => :yosemite
  end

  def install
    system "./configure", "--prefix=#{prefix}"
    system "make"
    system "make -C test alltests"
    ENV.deparallelize  # make install fails in parallel.
    system "make install"
  end
end
