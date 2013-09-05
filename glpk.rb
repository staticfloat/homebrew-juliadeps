require 'formula'

class Glpk < Formula
  homepage 'http://www.gnu.org/software/glpk/'
  url 'http://ftpmirror.gnu.org/glpk/glpk-4.48.tar.gz'
  mirror 'http://ftp.gnu.org/gnu/glpk/glpk-4.48.tar.gz'
  sha1 'e00c92faa38fd5d865fa27206abbb06680bab7bb'

  bottle do
    root_url 'http://archive.org/download/julialang/bottles'
    revision 1
    cellar :any
    sha1 'd87fa79e0b36cfe6fc772fad6731e026d74035bc' => :mountain_lion
    sha1 'd87fa79e0b36cfe6fc772fad6731e026d74035bc' => :lion
    sha1 'd87fa79e0b36cfe6fc772fad6731e026d74035bc' => :snow_leopard
  end

  def install
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make install"
  end
end
