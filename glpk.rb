require 'formula'

class Glpk < Formula
  homepage 'http://www.gnu.org/software/glpk/'
  url 'http://ftpmirror.gnu.org/glpk/glpk-4.52.tar.gz'
  mirror 'http://ftp.gnu.org/gnu/glpk/glpk-4.52.tar.gz'
  sha1 '44b30b0de777a0a07e00615ac6791af180ff4d2c'

  bottle do
    root_url 'http://archive.org/download/julialang/bottles'
    cellar :any
    sha1 'c1cf5b3ceb8c9275df469aeefeeb09631f1affff' => :mavericks
    sha1 'c1cf5b3ceb8c9275df469aeefeeb09631f1affff' => :mountain_lion
    sha1 'c1cf5b3ceb8c9275df469aeefeeb09631f1affff' => :lion
    sha1 'c1cf5b3ceb8c9275df469aeefeeb09631f1affff' => :snow_leopard
  end

  def install
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make install"
  end
end
