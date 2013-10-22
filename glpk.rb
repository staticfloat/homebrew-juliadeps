require 'formula'

class Glpk < Formula
  homepage 'http://www.gnu.org/software/glpk/'
  url 'http://ftpmirror.gnu.org/glpk/glpk-4.52.tar.gz'
  mirror 'http://ftp.gnu.org/gnu/glpk/glpk-4.52.tar.gz'
  sha1 '44b30b0de777a0a07e00615ac6791af180ff4d2c'

  bottle do
    root_url 'http://archive.org/download/julialang/bottles'
    cellar :any
    revision 2
    sha1 'aa923cb3f5d87f045b28aaaad57b63cadf034a95' => :mountain_lion
    sha1 'aa923cb3f5d87f045b28aaaad57b63cadf034a95' => :lion
    sha1 'aa923cb3f5d87f045b28aaaad57b63cadf034a95' => :snow_leopard
  end

  def install
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make install"
  end
end
