require "formula"

class Scs < Formula
  homepage 'https://github.com/cvxgrp/scs'
  url 'https://github.com/cvxgrp/scs/archive/v1.2.6.tar.gz'
  head 'https://github.com/cvxgrp/scs.git'
  sha256 'b4bebb43a1257b6e88a5f97c855c0559d6c8a8c0548d3156fc5a28d82bb9533f'

  bottle do
    root_url 'https://juliabottles.s3.amazonaws.com'
    cellar :any
  end

  def install
    # Make 32-bit build
    ENV['CFLAGS'] = "-DDLONG -DCOPYAMATRIX -DLAPACK_LIB_FOUND -DCTRLC"
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
