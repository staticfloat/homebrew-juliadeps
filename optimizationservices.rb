require 'formula'

class Optimizationservices < Formula
  homepage 'https://projects.coin-or.org/OS'
  url 'http://www.coin-or.org/download/pkgsource/OS/OS-2.10.1.tgz'
  sha256 'fb171e705b81be59f7ede188f29aa0720c558e1e00da74920dce894e7f9e72eb'

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
