require 'formula'

class Szip < Formula
  homepage 'http://www.hdfgroup.org/HDF5/release/obtain5.html#extlibs'
  url 'http://www.hdfgroup.org/ftp/lib-external/szip/2.1/src/szip-2.1.tar.gz'
  sha1 'd241c9acc26426a831765d660b683b853b83c131'

  bottle do
    root_url 'http://archive.org/download/julialang/bottles'
    cellar :any
    sha1 'aba8816400fd8dcb5dcc276a82d29b65a001cfb2' => :mountain_lion
    sha1 'aba8816400fd8dcb5dcc276a82d29b65a001cfb2' => :lion
    sha1 'aba8816400fd8dcb5dcc276a82d29b65a001cfb2' => :snow_leopard
    sha1 'aba8816400fd8dcb5dcc276a82d29b65a001cfb2' => :mavericks
  end

  option :universal

  def install
    ENV.universal_binary if build.universal?
    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make install"
  end
end
