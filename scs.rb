require "formula"

class Scs < Formula
  homepage 'https://github.com/cvxgrp/scs'
  url 'https://github.com/cvxgrp/scs/archive/v1.1.8.tar.gz'
  head 'https://github.com/cvxgrp/scs.git'
  sha256 '4249df60aa3c27d6b4d46a162a766d3e391f7771ef3a3a68edd5380176c3ae92'

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
