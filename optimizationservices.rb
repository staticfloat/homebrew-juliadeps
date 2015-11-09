require 'formula'

class Optimizationservices < Formula
  homepage 'https://projects.coin-or.org/OS'
  url 'http://www.coin-or.org/download/pkgsource/OS/OS-2.9.3.tgz'

  depends_on 'staticfloat/juliadeps/pkg-config' => :build
  depends_on 'staticfloat/juliadeps/couenne'
  depends_on 'homebrew/science/cppad' => :build

  bottle do
    root_url 'https://juliabottles.s3.amazonaws.com'
    cellar :any
  end

  def install
    system "./configure", "--prefix=#{prefix}"
    system "make"
    system "make -C test alltests"
    ENV.deparallelize  # make install fails in parallel.
    system "make install"
  end
end
