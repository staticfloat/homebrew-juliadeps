require 'formula'

class Szip < Formula
  homepage 'http://www.hdfgroup.org/HDF5/release/obtain5.html#extlibs'
  url 'http://www.hdfgroup.org/ftp/lib-external/szip/2.1/src/szip-2.1.tar.gz'
  sha1 'd241c9acc26426a831765d660b683b853b83c131'

  bottle do
    root_url 'https://juliabottles.s3.amazonaws.com'
    cellar :any
    revision 1
    sha1 '34af56a0a4fa1b52d9f0cabb3ed9ad49e39c7e9b' => :lion
    sha1 '45f68c96496c4b17121ec8ddd1e537de7d7d85b6' => :mavericks
    sha1 'e5371d215c05f7c279b7614801f9a8c2eea5a2c1' => :mountain_lion
    sha1 "284660a3cbab79726e2271053e6fec472fc5d857" => :yosemite
  end

  option :universal

  def install
    ENV.universal_binary if build.universal?
    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make install"
  end
end
