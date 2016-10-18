require 'formula'

class Couenne < Formula
  homepage 'https://projects.coin-or.org/Couenne'
  url 'http://www.coin-or.org/download/pkgsource/Couenne/Couenne-0.5.6.tgz'
  sha256 '60b5218ff1d878868a18e96f74cb3e816743f68b327522641c5ea8f1174ee7a6'

  depends_on 'pkg-config' => :build
  depends_on 'staticfloat/juliadeps/bonmin'

  bottle do
    root_url 'https://juliabottles.s3.amazonaws.com'
    cellar :any
    rebuild 1
    sha256 "117edf458a9ac707de24ec480ec2a6f4ae4448525c6620b9c30f6600ef37a651" => :mavericks
    sha256 "5d852dc3973ee24ebc3f5b924dd082fcfb16510ab62d1f1762060e91a7b43d73" => :yosemite
    sha256 "c5f4160692286d5c24303f9a4163186042f4c249e04088182a2f59023cd8dc62" => :el_capitan
    sha256 "aad61d4043da6f9ed4a837b48dc480dc3394b5ef6d713ab78f5d6e0ccc1634d0" => :sierra
  end

  def install
    system "./configure", "--prefix=#{prefix}"
    system "make"
    system "make test"
    ENV.deparallelize  # make install fails in parallel.
    system "make install"
  end
end
