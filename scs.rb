require "formula"

class Scs < Formula
  homepage "https://github.com/cvxgrp/scs"
  url "https://github.com/cvxgrp/scs/archive/v1.0.7.tar.gz"
  head "https://github.com/cvxgrp/scs.git"
  sha1 "fac3869989770f60d451fe4bd3c14afb7f73ae9f"

  def install
    default_cflags="-g -Wall -pedantic -O3 -funroll-loops -Wstrict-prototypes -I. -Iinclude"
    system "make CFLAGS='#{default_cflags} -DDLONG' USE_LAPACK=1 LDFLAGS=''"
    lib.install "out/libscsdir.dylib"
  end
end
