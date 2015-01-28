require 'formula'

class Bonmin < Formula
  homepage 'https://projects.coin-or.org/Bonmin'
  url 'http://www.coin-or.org/download/pkgsource/Bonmin/Bonmin-1.8.1.tgz'
  sha1 '488fb7c7c3dee30121cc6b3302e39fa0a163ae8e'

  depends_on 'staticfloat/juliadeps/pkg-config' => :build
  depends_on 'staticfloat/juliadeps/cbc'
  depends_on 'staticfloat/juliadeps/ipopt'

  def install
    system "./configure", "--prefix=#{prefix}"
    system "make"
    system "make test"
    ENV.deparallelize  # make install fails in parallel.
    system "make install"
  end
end
