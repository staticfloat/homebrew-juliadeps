require 'formula'

class Cppad < Formula
  homepage 'https://projects.coin-or.org/CppAD'
  url 'http://www.coin-or.org/download/source/CppAD/cppad-20150000.8.epl.tgz'
  sha1 'e225a0e86e0937df89efbffb8e0838b0905594a4'

  # note that homebrew-science has a fancier version of this formula that uses cmake for configuration

  def install
    system "./configure", "--prefix=#{prefix}"
    system "make"
    ENV.deparallelize  # make install fails in parallel.
    system "make install"
  end
end
