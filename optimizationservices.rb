require 'formula'

class Optimizationservices < Formula
  homepage 'https://projects.coin-or.org/OS'
  url 'http://www.coin-or.org/download/pkgsource/OS/OS-2.9.0.tgz'
  sha1 '1ffd200035ef8d883a74659028e5df0861710192'

  depends_on 'staticfloat/juliadeps/pkg-config' => :build
  depends_on 'staticfloat/juliadeps/couenne'
  depends_on 'staticfloat/juliadeps/cppad'

  def install
    system "./configure", "--prefix=#{prefix}",
                          "--enable-dependency-linking"
    system "make"
    ENV.deparallelize  # make install fails in parallel.
    system "make install"
  end
end
