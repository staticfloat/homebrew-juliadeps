require 'formula'
require "#{File.dirname(__FILE__)}/libgfortran"

class Ipopt < Formula
  homepage 'https://projects.coin-or.org/Ipopt'
  url 'http://www.coin-or.org/download/source/Ipopt/Ipopt-3.11.8.tgz'
  sha1 '530d718fb5a0c994c305deb3bcfdacc16cc0e2ef'
  revision 1

  bottle do
    root_url 'https://juliabottles.s3.amazonaws.com'
    cellar :any
    sha1 "3b36f111eb54582ed1af4f84c45e5b9998309b80" => :mountain_lion
    sha1 "08a38e99c509b8aae5f8daba9a76eb1b28ede2b1" => :mavericks
    sha1 "368560e856b40094ce63bac04a274f65bc1aa990" => :yosemite
  end

  # Need this snippet in every formula that has a runtime dependency on libgfortran
  def post_install
    fixup_libgfortran prefix
  end

  # Need to enable this when building the bottle, disable it when installing from bottles
  depends_on :fortran if ARGV.build_bottle?
  depends_on 'staticfloat/juliadeps/libgfortran'

  def install
    system "cd ThirdParty/Blas; ./get.Blas"
    system "cd ThirdParty/Blas; ./configure --prefix=#{prefix} --disable-shared --with-pic; make install"
    system "cd ThirdParty/Lapack; ./get.Lapack"
    system "cd ThirdParty/Lapack; ./configure --prefix=#{prefix} --disable-shared --with-pic; make install"
    system "cd ThirdParty/Mumps; ./get.Mumps"
    system "./configure", "--disable-dependency-tracking",
                          "--enable-dependency-linking",
                          "--with-blas=#{prefix}/lib/libcoinblas.a",
                          "--with-lapack=#{prefix}/lib/libcoinlapack.a",
                          "--prefix=#{prefix}"
    system "make"
    system "make test"
    ENV.deparallelize  # make install fails in parallel.
    system "make install"
  end
end
