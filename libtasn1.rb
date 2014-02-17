require 'formula'

class Libtasn1 < Formula
  homepage 'http://www.gnu.org/software/libtasn1/'
  url 'http://ftpmirror.gnu.org/libtasn1/libtasn1-3.4.tar.gz'
  mirror 'http://ftp.gnu.org/gnu/libtasn1/libtasn1-3.4.tar.gz'
  sha1 'f0e95f58b3c37405d48b91a585b517a4134586a9'

  bottle do
    root_url 'http://archive.org/download/julialang/bottles'
    cellar :any
    sha1 'bd54eb48444ccdbf28b833641e50b61157f55301' => :snow_leopard_or_later
  end

  option :universal

  def install
    ENV.universal_binary if build.universal?
    system "./configure", "--prefix=#{prefix}", "--disable-dependency-tracking"
    system "make install"
  end
end
