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
    rebuild 1
    sha256 "864fc4aaa281aad23b98a7dbb306253fe4deba6fc3eea7e8bcb1217f8893ec84" => :mavericks
    sha256 "2c26c1fa279d74b42544adf756ba4fd3d82a72a1bab8843ee80ecf4727f32973" => :yosemite
    sha256 "1336859c26be5464f2faa67e5c52f605ee7e767daebe08ede9af26f5dd10027a" => :el_capitan
    sha256 "367a1da636dc0d22449271d06ae41be53520b71bb1e386447950e9230ac2aa88" => :sierra
  end

  def install
    system "./configure", "--prefix=#{prefix}"
    system "make"
    system "make -C test alltests"
    ENV.deparallelize  # make install fails in parallel.
    system "make install"
  end
end
