require "formula"

class Scs < Formula
  homepage "https://github.com/cvxgrp/scs"
  url "https://github.com/cvxgrp/scs/archive/v1.0.7.tar.gz"
  head "https://github.com/cvxgrp/scs.git"
  sha1 "fac3869989770f60d451fe4bd3c14afb7f73ae9f"

  bottle do
    root_url 'https://juliabottles.s3.amazonaws.com'
    cellar :any
  end

  def install
    ENV['CFLAGS'] = "-DDLONG -DLAPACK_LIB_FOUND"
    ENV['LDFLAGS'] = "-undefined suppress -flat_namespace"
    system "make out/libscsdir.dylib"
    lib.install "out/libscsdir.dylib"
  end
end
