require 'formula'

class Couenne < Formula
  homepage 'https://projects.coin-or.org/Couenne'
  url 'http://www.coin-or.org/download/pkgsource/Couenne/Couenne-0.5.3.tgz'
  sha1 '69aac718467c1203ca88ea9711fa4028ebf8d4ce'

  depends_on 'staticfloat/juliadeps/pkg-config' => :build
  depends_on 'staticfloat/juliadeps/bonmin'

  bottle do
    root_url 'https://juliabottles.s3.amazonaws.com'
    cellar :any
    sha256 "d4a064bfd4f2af23857c393758bd28e249e94002755fc56df26aa57d438e2d82" => :mountain_lion
    sha256 "6acf6cf47f906b732bd12bf6e87abbf82b63bccd2bb0cb74100d34a33bc4335f" => :mavericks
    sha256 "5b0ed2272aae57d13558b73be2358d807c2bd2a8c6e005f1998a466b3e8dd204" => :yosemite
  end

  def install
    system "./configure", "--prefix=#{prefix}"
    system "make"
    system "make test"
    ENV.deparallelize  # make install fails in parallel.
    system "make install"
  end
end
