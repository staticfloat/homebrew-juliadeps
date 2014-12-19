require "formula"

class Scs < Formula
  homepage "https://github.com/cvxgrp/scs"
  url "https://github.com/cvxgrp/scs/archive/1.0.2.tar.gz"
  head "https://github.com/cvxgrp/scs.git"
  sha1 "c4667c0cfe3a8235375ea065a71fbbb5da3063b9"

  def install
    default_cflags="-g -Wall -pedantic -O3 -funroll-loops -Wstrict-prototypes -I. -Iinclude"
    system "make CFLAGS='#{default_cflags} -DDLONG' USE_LAPACK=1 LDFLAGS=''"
    lib.install "out/libscsdir.dylib"
  end
end
