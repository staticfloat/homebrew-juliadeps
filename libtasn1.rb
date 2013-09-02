require 'formula'

class Libtasn1 < Formula
  homepage 'http://www.gnu.org/software/libtasn1/'
  url 'http://ftpmirror.gnu.org/libtasn1/libtasn1-3.3.tar.gz'
  mirror 'http://ftp.gnu.org/gnu/libtasn1/libtasn1-3.3.tar.gz'
  sha1 '594a2b65742e45b0abf140ea504fc06de2ca3b1e'

  option :universal

  bottle do
    root_url 'http://juliabottles.s3-website-us-east-1.amazonaws.com/bottles'
    cellar :any
    sha1 '6db8382603ba32054a7c1e135a2646c5f2580c29' => :mountain_lion
    sha1 '6db8382603ba32054a7c1e135a2646c5f2580c29' => :lion
    sha1 '6db8382603ba32054a7c1e135a2646c5f2580c29' => :snow_leopard
  end

  def install
    ENV.universal_binary if build.universal?
    system "./configure", "--prefix=#{prefix}", "--disable-dependency-tracking"
    system "make install"
  end
end
