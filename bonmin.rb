require 'formula'

class Bonmin < Formula
  homepage 'https://projects.coin-or.org/Bonmin'
  url 'http://www.coin-or.org/download/pkgsource/Bonmin/Bonmin-1.8.1.tgz'
  sha1 '488fb7c7c3dee30121cc6b3302e39fa0a163ae8e'

  depends_on 'staticfloat/juliadeps/pkg-config' => :build
  depends_on 'staticfloat/juliadeps/cbc'
  depends_on 'staticfloat/juliadeps/ipopt'

  bottle do
    cellar :any
    root_url 'https://juliabottles.s3.amazonaws.com'
    revision 1
    sha256 "d32e4898dde9618446a18878df406d48982095d2433c715eda76d41a8a549a38" => :mavericks
    sha256 "7b01c27e2c45f4944dd6f3ce7492e29247c9443bb730a51ecb9a79b6c12a657b" => :yosemite
  end

  def install
    system "./configure", "--prefix=#{prefix}"
    system "make"
    system "make test"
    ENV.deparallelize  # make install fails in parallel.
    system "make install"
  end
end
