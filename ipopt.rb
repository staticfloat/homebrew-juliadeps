require 'formula'

class Ipopt < Formula
  homepage 'https://projects.coin-or.org/Ipopt'
  url 'http://www.coin-or.org/download/source/Ipopt/Ipopt-3.11.7.tgz'
  sha1 '4547db1acbd65aad9edbed115a7812fbfd6d2d3a'

  bottle do
    root_url 'http://archive.org/download/julialang/bottles'
    cellar :any
    revision 1
    sha1 '3a544a272bb113c7b59c50fb4aba0ae4254c7042' => :snow_leopard_or_later
  end

  depends_on 'staticfloat/juliadeps/gfortran'

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
