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
    rebuild 1
    sha256 "9e9deac398abbc1c63ee7c1ff5ca0b5c5835267fe4c768e5a1ff973aaceb3c0b" => :mavericks
    sha256 "380eda292497e5552e3a89aa06e396b0d101b44b213165809ea367e3be6483cc" => :yosemite
    sha256 "e4e99dce874ae77ab540aa2ecaf0634cfa3acc04806ca66c927ae31e079d13e5" => :el_capitan
    sha256 "f7cdb4ea919c6f07b4da5aca6fb2dcc6440954ee22950ecdf61ee13dd86a6765" => :sierra
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
