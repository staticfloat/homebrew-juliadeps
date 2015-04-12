require 'formula'

class Optimizationservices < Formula
  homepage 'https://projects.coin-or.org/OS'
  url 'http://www.coin-or.org/download/pkgsource/OS/OS-2.9.1.tgz'
  sha1 'fd7bd169fb3925436f7a7ebdbf676a20b79140f0'

  depends_on 'staticfloat/juliadeps/pkg-config' => :build
  depends_on 'staticfloat/juliadeps/couenne'
  depends_on 'homebrew/science/cppad' => :build

  bottle do
    root_url 'https://juliabottles.s3.amazonaws.com'
    cellar :any
    sha256 "3f886b86b9a70377595621838d658155806648df14fc2e3442ce8695793b866e" => :mavericks
    sha256 "6b93fda9d6fb0770bac1031b52f16e823e27222d492071ef3a06a151f174acfb" => :yosemite
  end

  def install
    system "./configure", "--prefix=#{prefix}"
    system "make"
    system "make -C test alltests"
    ENV.deparallelize  # make install fails in parallel.
    system "make install"
  end
end
