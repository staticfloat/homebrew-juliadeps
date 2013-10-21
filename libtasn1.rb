require 'formula'

class Libtasn1 < Formula
  homepage 'http://www.gnu.org/software/libtasn1/'
  url 'http://ftpmirror.gnu.org/libtasn1/libtasn1-3.3.tar.gz'
  mirror 'http://ftp.gnu.org/gnu/libtasn1/libtasn1-3.3.tar.gz'
  sha1 '594a2b65742e45b0abf140ea504fc06de2ca3b1e'

  bottle do
    root_url 'http://archive.org/download/julialang/bottles'
    cellar :any
    revision 1
    sha1 'bc115d0d85dbd9847f7e1675f442f705112dd937' => :mountain_lion
    sha1 'bc115d0d85dbd9847f7e1675f442f705112dd937' => :lion
    sha1 'bc115d0d85dbd9847f7e1675f442f705112dd937' => :snow_leopard
  end

  option :universal


  def install
    ENV.universal_binary if build.universal?
    system "./configure", "--prefix=#{prefix}", "--disable-dependency-tracking"
    system "make install"
  end
end
