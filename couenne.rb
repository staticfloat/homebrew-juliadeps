require 'formula'

class Couenne < Formula
  homepage 'https://projects.coin-or.org/Couenne'
  url 'http://www.coin-or.org/download/pkgsource/Couenne/Couenne-0.5.3.tgz'
  sha1 '69aac718467c1203ca88ea9711fa4028ebf8d4ce'

  depends_on 'staticfloat/juliadeps/pkg-config' => :build
  depends_on 'staticfloat/juliadeps/bonmin'

  def install
    system "./configure", "--prefix=#{prefix}"
    system "make"
    system "make test"
    ENV.deparallelize  # make install fails in parallel.
    system "make install"
  end
end
