require 'formula'

class Bonmin < Formula
  homepage 'https://projects.coin-or.org/Bonmin'
  url 'http://www.coin-or.org/download/pkgsource/Bonmin/Bonmin-1.8.1.tgz'
  sha1 '488fb7c7c3dee30121cc6b3302e39fa0a163ae8e'

  depends_on 'staticfloat/juliadeps/pkg-config' => :build
  depends_on 'staticfloat/juliadeps/cbc'
  depends_on 'staticfloat/juliadeps/ipopt'

  bottle do
    cellar :any
    sha1 "77dee65e7feff6c97af92677ccb404e1175fd16a" => :yosemite
    sha1 "d5a08710ede17f3d2ca57f82d77d3b4bbf6ffd29" => :mavericks
    sha1 "4a3dd43a64be65a8bf128f14cce6c780e9dc6e36" => :mountain_lion
  end

  def install
    system "./configure", "--prefix=#{prefix}"
    system "make"
    system "make test"
    ENV.deparallelize  # make install fails in parallel.
    system "make install"
  end
end
