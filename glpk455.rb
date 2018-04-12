require 'formula'

class Glpk455 < Formula
  homepage 'https://www.gnu.org/software/glpk/'
  url 'https://ftpmirror.gnu.org/glpk/glpk-4.55.tar.gz'
  mirror 'https://ftp.gnu.org/gnu/glpk/glpk-4.55.tar.gz'
  sha256 '37090d7f16796ec1034496e182a39d5cc8bb7c9fb5dc48a38b13d620bf2b1de7'

  bottle do
    root_url 'https://juliabottles.s3.amazonaws.com'
    cellar :any
    rebuild 1
    sha256 "d6df75161253b67c7bc2376b1e88ae4fb14a38cb0d8676a9a4555b1baf246004" => :mavericks
    sha256 "ea0e706f602fd4dc19481f729bfc5806638b70086b082e2355678ae99978f79d" => :yosemite
    sha256 "9ad7ab4e04c3244cbcc4f6f1bae4296b825000c06b2ccd5d796d423b8cdd450d" => :el_capitan
    sha256 "99b0070abbe28a0b55416f6c9561a6e369039f2a88f9b4b479c1cde7cede20d3" => :sierra
  end

  def install
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make install"
  end
end
