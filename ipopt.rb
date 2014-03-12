require 'formula'

class Ipopt < Formula
  homepage 'https://projects.coin-or.org/Ipopt'
  url 'http://www.coin-or.org/download/source/Ipopt/Ipopt-3.11.5.tgz'
  sha1 '66e3ae03179ba7541a478d185b256f336159fc6d'

  bottle do
    root_url 'http://archive.org/download/julialang/bottles'
    cellar :any
    sha1 '06b77455a570abafc1c88825afcd6f0af23586ef' => :mountain_lion
    sha1 '06b77455a570abafc1c88825afcd6f0af23586ef' => :lion
    sha1 '06b77455a570abafc1c88825afcd6f0af23586ef' => :snow_leopard
    sha1 '06b77455a570abafc1c88825afcd6f0af23586ef' => :mavericks
  end

  depends_on 'staticfloat/juliadeps/gfortran'

  def install
    system "cd ThirdParty/Mumps; ./get.Mumps"
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make"
    system "make test"
    ENV.deparallelize  # make install fails in parallel.
    system "make install"
  end
end
