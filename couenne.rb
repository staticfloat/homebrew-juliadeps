require 'formula'

class Couenne < Formula
  homepage 'https://projects.coin-or.org/Couenne'
  url 'http://www.coin-or.org/download/pkgsource/Couenne/Couenne-0.5.4.tgz'
  sha1 '1081ba62447744b27c5bc67d3d2103a3bcc42ed9'

  depends_on 'staticfloat/juliadeps/pkg-config' => :build
  depends_on 'staticfloat/juliadeps/bonmin'

  bottle do
    root_url 'https://juliabottles.s3.amazonaws.com'
    cellar :any
    sha256 "5b50a589ada479b95466e7c9144c22f4ae3aaf156592c335c0882b392284e5ee" => :yosemite
    sha256 "6ec4d4ff3720a09478f760e0820037922d6d6e952d894eb465d51c821cc620fe" => :mavericks
  end

  def install
    system "./configure", "--prefix=#{prefix}"
    system "make"
    system "make test"
    ENV.deparallelize  # make install fails in parallel.
    system "make install"
  end
end
