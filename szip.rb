require 'formula'

class Szip < Formula
  homepage 'http://www.hdfgroup.org/HDF5/release/obtain5.html#extlibs'
  url 'http://www.hdfgroup.org/ftp/lib-external/szip/2.1/src/szip-2.1.tar.gz'
  sha256 'a816d95d5662e8279625abdbea7d0e62157d7d1f028020b1075500bf483ed5ef'

  bottle do
    root_url 'https://juliabottles.s3.amazonaws.com'
    cellar :any
  end

  option :universal

  def install
    ENV.universal_binary if build.universal?
    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make install"
  end
end
