require 'formula'

class Glpk < Formula
  homepage 'http://www.gnu.org/software/glpk/'
  url 'http://ftpmirror.gnu.org/glpk/glpk-4.52.tar.gz'
  mirror 'http://ftp.gnu.org/gnu/glpk/glpk-4.52.tar.gz'
  sha1 '44b30b0de777a0a07e00615ac6791af180ff4d2c'

  bottle do
    root_url 'https://juliabottles.s3.amazonaws.com'
    cellar :any
    revision 3
    sha1 '75c88f64f6e1553ed384464b002cc8a8690f275b' => :lion
    sha1 'e61fe1e67b932d6b80d81d91dcf6b4beb215c68f' => :mavericks
    sha1 '15148c18db8712983c2fb3733636b9e989f1ca3b' => :mountain_lion
  end

  def install
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make install"
  end
end
