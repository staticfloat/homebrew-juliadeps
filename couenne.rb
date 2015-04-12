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
    sha256 "d70ed6d0f461ff8909474d8d93aab94932862d0c46e717762c7899a4b9264aaf" => :yosemite
    sha256 "4c381369a3e82fdbbb040873def8428db4c6ef22b4d5db4622d40da16f03ea8e" => :mavericks
  end

  def install
    system "./configure", "--prefix=#{prefix}"
    system "make"
    system "make test"
    ENV.deparallelize  # make install fails in parallel.
    system "make install"
  end
end
