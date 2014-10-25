require 'formula'
require "#{File.dirname(__FILE__)}/libgfortran"

class Ipopt < Formula
  homepage 'https://projects.coin-or.org/Ipopt'
  url 'http://www.coin-or.org/download/source/Ipopt/Ipopt-3.11.8.tgz'
  sha1 '530d718fb5a0c994c305deb3bcfdacc16cc0e2ef'

  bottle do
    root_url 'https://juliabottles.s3.amazonaws.com'
    cellar :any
    revision 1
    sha1 '69e01274eb64e92572f911bc6cca9efadc82b3eb' => :lion
    sha1 '19e1eaf45f56bda34fb81df63e96886a6f8184c8' => :mavericks
    sha1 'c5b113de6f32c505b3836466fee044df7b382108' => :mountain_lion
  end

  # Need this snippet in every formula that has a runtime dependency on libgfortran
  def post_install
    fixup_libgfortran prefix
  end

  #depends_on :fortran => :build
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
