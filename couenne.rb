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
    sha256 "5945884f8192d5705f6011db410a7466c2c65295d02d02b21b049d707df1fcdf" => :yosemite
    sha256 "519ff4a8f8fd2a5cfb5cd8b7a6e4306f09c728195cb1c76b5156d4270b35b31d" => :el_capitan
    sha256 "d47d6572c2a7b2157c014e2c0b2313b7f77a030a41d14b90325433b9b00362cc" => :mavericks
  end

  def install
    system "./configure", "--prefix=#{prefix}"
    system "make"
    system "make test"
    ENV.deparallelize  # make install fails in parallel.
    system "make install"
  end
end
