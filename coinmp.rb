require 'formula'

class Coinmp < Formula
  homepage 'http://www.coin-or.org/projects/CoinMP.xml'
  url 'http://www.coin-or.org/download/source/CoinMP/CoinMP-1.7.6.tgz'
  sha1 'f52c74abcbf55c72cd89f709db658ea33ed45154'

  bottle do
    root_url 'http://archive.org/download/julialang/bottles'
    cellar :any
    sha1 '0fd33cacb9b152a396151b54013fd47bf52904c4' => :snow_leopard_or_later
  end

  depends_on 'staticfloat/juliadeps/gfortran'

  #conflicts_with 'coinutils', :because => 'CoinMP includes CoinUtils.'

  #patch :p1 do
  #  url "https://raw.githubusercontent.com/JuliaOpt/Cbc.jl/a5cd0c528c7f2e8895b9d6955bf3d96dd884157d/deps/CoinMP-emptyproblem.patch"
  #  sha1 "f55e6d24bba7fe39fe0cf5d6b85cffb4a1f7c4ea"
  #end

  def install
    # build without lapack until OpenBLAS issue 306 is resolved
    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}", "--without-lapack", 
                          "--enable-dependency-linking"
    system "make"
    ENV.deparallelize  # make install fails in parallel.
    system "make install"

  end
end
