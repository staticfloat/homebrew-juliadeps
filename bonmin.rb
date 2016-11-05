require 'formula'

class Bonmin < Formula
  homepage 'https://projects.coin-or.org/Bonmin'
  url 'http://www.coin-or.org/download/pkgsource/Bonmin/Bonmin-1.8.4.tgz'
  sha256 'f533d351c1965ccdac823e8758e435b806786833fc2eff67ca5004013b25db51'

  depends_on 'pkg-config' => :build
  depends_on 'staticfloat/juliadeps/cbc'
  depends_on 'staticfloat/juliadeps/ipopt'

  bottle do
    cellar :any
    root_url 'https://juliabottles.s3.amazonaws.com'
    rebuild 1
    sha256 "bdae1b53c599fa4c3ed2992d6f9aa7583fa8129c5f6a621d50a9d2002d6e539e" => :mavericks
    sha256 "325055e9b4a3cf14a06159431eaa3d410cdb13ec062068bb98405bbf3bbd6d6c" => :yosemite
    sha256 "dee23b2aa168e1c8ff4576f80d656172e687e6b7c20f1abf8d15222cfcdf1cd3" => :el_capitan
    sha256 "d5d324979587e1d9c64eb8756051d87c44d361543e386d00195116243d722a3e" => :sierra
  end

  def install
    system "./configure", "--prefix=#{prefix}"
    system "make"
    system "make test"
    ENV.deparallelize  # make install fails in parallel.
    system "make install"
  end
end
