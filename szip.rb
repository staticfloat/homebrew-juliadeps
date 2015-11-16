require 'formula'

class Szip < Formula
  homepage 'http://www.hdfgroup.org/HDF5/release/obtain5.html#extlibs'
  url 'http://www.hdfgroup.org/ftp/lib-external/szip/2.1/src/szip-2.1.tar.gz'
  sha256 'a816d95d5662e8279625abdbea7d0e62157d7d1f028020b1075500bf483ed5ef'
  revision 1

  bottle do
    root_url 'https://juliabottles.s3.amazonaws.com'
    cellar :any
    sha256 "ec54e3c66ac599d71b44d971b2b25a09158b01400ff546190a5b3176313dc1ed" => :mavericks
    sha256 "95a96ce6a89b106c207c101cf558ee48d426d785d74701117f00aae1757ad0b0" => :yosemite
    sha256 "b4b4099411b1d91af315c59cbe7deec08cb8b049db151ec3e78a76c6f62b81ef" => :el_capitan
  end

  option :universal

  def install
    ENV.universal_binary if build.universal?
    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make install"
  end
end
