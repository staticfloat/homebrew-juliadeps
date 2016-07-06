require 'formula'
require "#{File.dirname(__FILE__)}/libgfortran"

class Ipopt < Formula
  homepage 'https://projects.coin-or.org/Ipopt'
  url 'http://www.coin-or.org/download/source/Ipopt/Ipopt-3.12.4.tgz'
  sha256 '292afd952c25ec9fe6225041683dcbd3cb76e15a128764671927dbaf881c2e89'
  revision 1

  bottle do
    root_url 'https://juliabottles.s3.amazonaws.com'
    cellar :any
    sha256 "1866df675a818e3f3bca6539edb7b2f55078df4e02fbea00755a8965a0bad134" => :mavericks
    sha256 "1b82449de95a197d97721aa6592f4acc245f8006727fb9af9cd6aaaf71c9181c" => :yosemite
    sha256 "646df8e7f7b4799a26f08df1716cf4947fb4ee86409745e2073744d5e656d81d" => :el_capitan
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
    system "cd ThirdParty/ASL; ./get.ASL"
    system "cd ThirdParty/Mumps; ./get.Mumps"
    system "./configure", "--disable-dependency-tracking",
                          "--with-blas=#{prefix}/lib/libcoinblas.a",
                          "--with-lapack=#{prefix}/lib/libcoinlapack.a",
                          "--prefix=#{prefix}"
    system "make"
    system "make test"
    ENV.deparallelize  # make install fails in parallel.
    system "make install"
  end
end
