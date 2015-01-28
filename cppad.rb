require 'formula'

class Cppad < Formula
  homepage 'https://projects.coin-or.org/CppAD'
  url 'http://www.coin-or.org/download/source/CppAD/cppad-20150000.3.epl.tgz'
  sha1 'a07c132441835a24dfb60f205124492acb64f523'

  # note that homebrew-science has a fancier version of this formula that uses cmake for configuration

  def install
    system "./configure", "--prefix=#{prefix}"
    system "make"
    ENV.deparallelize  # make install fails in parallel.
    system "make install"
  end
end
