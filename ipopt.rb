require 'formula'
require "#{File.dirname(__FILE__)}/libgfortran"

class Ipopt < Formula
  homepage 'https://projects.coin-or.org/Ipopt'
  url 'http://www.coin-or.org/download/source/Ipopt/Ipopt-3.12.1.tgz'
  sha1 'cbb197f6a90e0e1d64e438a5159da5f33f06aa08'
  revision 2

  bottle do
    root_url 'https://juliabottles.s3.amazonaws.com'
    cellar :any
    sha256 "c46db8ce06d8586535f2067f8bff8774f6a241591e30a29dc2befa98bd8bca44" => :mountain_lion
    sha256 "5694b945d19acbbe3c869426fa72014c6caf8c97689d1f4fa96d3570bf8770b4" => :mavericks
    sha256 "6fe5a5dd701a82f97a5ecacdc01ce95176817ce3cca7690207d914d598945ce2" => :yosemite
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
