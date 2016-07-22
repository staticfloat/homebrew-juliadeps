require 'formula'

class Optimizationservices < Formula
  homepage 'https://projects.coin-or.org/OS'
  url 'http://www.coin-or.org/download/pkgsource/OS/OS-2.9.3.tgz'

  depends_on 'pkg-config' => :build
  depends_on 'staticfloat/juliadeps/couenne'
  depends_on 'homebrew/science/cppad' => :build

  bottle do
    root_url 'https://juliabottles.s3.amazonaws.com'
    cellar :any
    sha256 "2aa3c32d2a2c9b8ead4edf05bf66cc97f585407f7dc3caafb8f1dfbbb418305a" => :mavericks
    sha256 "2d97543470f5d7518b54ee4129176578ee7356c05a1e946d6c3fb9280d8b2e41" => :yosemite
    sha256 "9ec6978287a9536b13a9d165f2c6d69c1e43432a9b56456b3ed922969344e860" => :el_capitan
  end

  def install
    system "./configure", "--prefix=#{prefix}"
    system "make"
    system "make -C test alltests"
    ENV.deparallelize  # make install fails in parallel.
    system "make install"
  end
end
