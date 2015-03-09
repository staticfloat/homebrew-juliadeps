require 'formula'

class Optimizationservices < Formula
  homepage 'https://projects.coin-or.org/OS'
  url 'http://www.coin-or.org/download/pkgsource/OS/OS-2.9.1.tgz'
  sha1 'fd7bd169fb3925436f7a7ebdbf676a20b79140f0'

  depends_on 'staticfloat/juliadeps/pkg-config' => :build
  depends_on 'staticfloat/juliadeps/couenne'
  depends_on 'staticfloat/juliadeps/cppad'

  def install
    system "./configure", "--prefix=#{prefix}"
    system "make"
    ENV.deparallelize  # make install fails in parallel.
    system "make install"
  end
end
