require 'formula'

class Glpk454 < Formula
  homepage 'http://www.gnu.org/software/glpk/'
  url 'http://ftpmirror.gnu.org/glpk/glpk-4.54.tar.gz'
  mirror 'http://ftp.gnu.org/gnu/glpk/glpk-4.54.tar.gz'
  sha1 '69d9c5d83271d34de1a58d2de2f7ababab975492'

  def install
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make install"
  end
end
