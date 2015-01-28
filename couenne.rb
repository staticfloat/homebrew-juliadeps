require 'formula'

class Couenne < Formula
  homepage 'https://projects.coin-or.org/Couenne'
  url 'http://www.coin-or.org/download/pkgsource/Couenne/Couenne-0.5.1.tgz'
  sha1 '1efd0e75d93c0efccd80e444b50d41bde16536fc'

  depends_on 'staticfloat/juliadeps/pkg-config' => :build
  depends_on 'staticfloat/juliadeps/bonmin'

  def install
    system "./configure", "--prefix=#{prefix}",
                          "--enable-dependency-linking"
    system "make"
    ENV.deparallelize  # make install fails in parallel.
    system "make install"
  end
end
