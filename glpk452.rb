require 'formula'

class Glpk452 < Formula
  homepage 'https://www.gnu.org/software/glpk/'
  url 'https://ftpmirror.gnu.org/glpk/glpk-4.52.tar.gz'
  mirror 'https://ftp.gnu.org/gnu/glpk/glpk-4.52.tar.gz'
  sha256 '9a5dab356268b4f177c33e00ddf8164496dc2434e83bd1114147024df983a3bb'

  bottle do
    root_url 'https://juliabottles.s3.amazonaws.com'
    cellar :any
    rebuild 1
    sha256 "7e338645b32b8943a411ae2e2656cc07b01647bcd5a4d2feeadfca8e3a318bf1" => :mavericks
    sha256 "5821200f19e0b2ed16a5fb66fb93363c0ff3ecc3311efc2ea4b542ab99248ca8" => :yosemite
    sha256 "65f2ca3905aff53007c966a6a13330341e2a93277b413fd86f8d28b4559fca27" => :el_capitan
    sha256 "f167fcae548409737308f8257107c548f490079695e683273e0090591ae1c4b4" => :sierra
  end

  def install
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make install"
  end
end
