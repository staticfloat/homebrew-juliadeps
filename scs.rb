require "formula"

class Scs < Formula
  homepage "https://github.com/cvxgrp/scs"
  url "https://github.com/cvxgrp/scs/archive/v1.1.5.tar.gz"
  head "https://github.com/cvxgrp/scs.git"
  sha1 "0f9f51d663efd75b9d55d9f6524da75baa498aee"
  revision 1

  def install
    # Make 32-bit build
    ENV['CFLAGS'] = "-DDLONG -DLAPACK_LIB_FOUND"
    ENV['LDFLAGS'] = "-undefined suppress -flat_namespace"
    system "make out/libscsdir.dylib"
    lib.install "out/libscsdir.dylib"

    ENV['CFLAGS'] += " -DBLAS64 -DBLASSUFFIX=_64_"
    system "make purge"
    system "make out/libscsdir.dylib"
    mv "out/libscsdir.dylib", "out/libscsdir64.dylib"
    lib.install "out/libscsdir64.dylib"
  end
end
