require 'formula'

class Couenne < Formula
  homepage 'https://projects.coin-or.org/Couenne'
  url 'http://www.coin-or.org/download/pkgsource/Couenne/Couenne-0.5.6.tgz'
  sha256 '60b5218ff1d878868a18e96f74cb3e816743f68b327522641c5ea8f1174ee7a6'

  depends_on 'staticfloat/juliadeps/pkg-config' => :build
  depends_on 'staticfloat/juliadeps/bonmin'

  bottle do
    root_url 'https://juliabottles.s3.amazonaws.com'
    cellar :any
  end

  def install
    system "./configure", "--prefix=#{prefix}"
    system "make"
    system "make test"
    ENV.deparallelize  # make install fails in parallel.
    system "make install"
  end
end
