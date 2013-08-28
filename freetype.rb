require 'formula'

class Freetype < Formula
  homepage 'http://www.freetype.org'
  url 'http://downloads.sf.net/project/freetype/freetype2/2.4.11/freetype-2.4.11.tar.gz'
  sha1 'a8373512281f74a53713904050e0d71c026bf5cf'

  option :universal

  bottle do
    root_url 'http://juliabottles.s3-website-us-east-1.amazonaws.com/bottles'
    cellar :any
    revision 1
    sha1 '5423027b4121ae83bd51240244caca700154e2ec' => :mountain_lion
    sha1 '5423027b4121ae83bd51240244caca700154e2ec' => :lion
    sha1 '5423027b4121ae83bd51240244caca700154e2ec' => :snow_leopard
  end

  def install
    ENV.universal_binary if build.universal?
    system "./configure", "--prefix=#{prefix}"
    system "make install"
  end

  test do
    system "#{bin}/freetype-config", '--cflags', '--libs', '--ftversion',
      '--exec-prefix', '--prefix'
  end
end
