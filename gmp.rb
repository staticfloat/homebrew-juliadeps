require 'formula'

class Gmp < Formula
  homepage 'http://gmplib.org/'
  url 'ftp://ftp.gmplib.org/pub/gmp-5.1.2/gmp-5.1.2.tar.bz2'
  mirror 'http://ftp.gnu.org/gnu/gmp/gmp-5.1.2.tar.bz2'
  sha1 '2cb498322b9be4713829d94dee944259c017d615'

  bottle do
    root_url 'http://archive.org/download/julialang/bottles'
    cellar :any
    revision 2
    sha1 'a55c253064287d96f9d8d6b064f1e415e3dd02ed' => :mountain_lion
    sha1 'a55c253064287d96f9d8d6b064f1e415e3dd02ed' => :lion
    sha1 'a55c253064287d96f9d8d6b064f1e415e3dd02ed' => :snow_leopard
  end

  option '32-bit'

  def install
    args = ["--prefix=#{prefix}", "--enable-cxx"]

    if build.build_32_bit?
      ENV.m32
      ENV.append 'ABI', '32'
      # https://github.com/mxcl/homebrew/issues/20693
      args << "--disable-assembly"
    end

    system "./configure", *args
    system "make"
    system "make check"
    ENV.deparallelize
    system "make install"
  end
end
