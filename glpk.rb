require 'formula'

class Glpk < Formula
  homepage 'http://www.gnu.org/software/glpk/'
  url 'http://ftpmirror.gnu.org/glpk/glpk-4.48.tar.gz'
  mirror 'http://ftp.gnu.org/gnu/glpk/glpk-4.48.tar.gz'
  sha1 'e00c92faa38fd5d865fa27206abbb06680bab7bb'

  bottle do
    root_url 'http://juliabottles.s3-website-us-east-1.amazonaws.com/bottles'
    cellar :any
    sha1 'ffb7607588c792a4cd4b082a6b674aff3f07eba6' => :mountain_lion
    sha1 'ffb7607588c792a4cd4b082a6b674aff3f07eba6' => :lion
    sha1 'ffb7607588c792a4cd4b082a6b674aff3f07eba6' => :snow_leopard
  end

  def install
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make install"
  end
end
