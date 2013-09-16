require 'formula'

class Glpk < Formula
  homepage 'http://www.gnu.org/software/glpk/'
  url 'http://ftpmirror.gnu.org/glpk/glpk-4.52.tar.gz'
  mirror 'http://ftp.gnu.org/gnu/glpk/glpk-4.52.tar.gz'
  sha1 '44b30b0de777a0a07e00615ac6791af180ff4d2c'

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
