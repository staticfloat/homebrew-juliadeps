require 'formula'

class Coinmp < Formula
  homepage 'http://www.coin-or.org/projects/CoinMP.xml'
  url 'http://www.coin-or.org/download/source/CoinMP/CoinMP-1.7.0.tgz'
  sha1 '27f58adc404a329f20a96a5218bc8ed332639ada'

  depends_on :fortran

  bottle do
    root_url 'http://archive.org/download/julialang/bottles'
    cellar :any
    sha1 'a0a721aed6ea13539ea6568ba613dd33b2b46222' => :mountain_lion
    sha1 'a0a721aed6ea13539ea6568ba613dd33b2b46222' => :lion
    sha1 'a0a721aed6ea13539ea6568ba613dd33b2b46222' => :snow_leopard
  end

  #conflicts_with 'coinutils', :because => 'CoinMP includes CoinUtils.'

  def patches
    { :p1 => ["https://raw.github.com/mlubin/CoinMP.jl/9fe259e1677a6917cba2f70d78010d2505a3908b/deps/CoinMP-makefile.patch",
      "https://raw.github.com/mlubin/CoinMP.jl/9fe259e1677a6917cba2f70d78010d2505a3908b/deps/CoinMP-strcmp.patch",
      "https://raw.github.com/mlubin/CoinMP.jl/9fe259e1677a6917cba2f70d78010d2505a3908b/deps/CoinMP-loglevel.patch"],
      :p0 => "https://raw.github.com/mlubin/CoinMP.jl/9fe259e1677a6917cba2f70d78010d2505a3908b/deps/Clp-interface.patch"
    }
  end

  def install
    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make"
    ENV.deparallelize  # make install fails in parallel.
    system "make install"

  end
end
