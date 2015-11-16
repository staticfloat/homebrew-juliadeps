require "formula"

class Scs < Formula
  homepage 'https://github.com/cvxgrp/scs'
  url 'https://github.com/cvxgrp/scs/archive/v1.1.8.tar.gz'
  head 'https://github.com/cvxgrp/scs.git'
  sha256 '4249df60aa3c27d6b4d46a162a766d3e391f7771ef3a3a68edd5380176c3ae92'

  bottle do
    root_url 'https://juliabottles.s3.amazonaws.com'
    cellar :any
    sha256 "6a74858d1d03f9fffbaae08621d5432cd612f7b4732d72459824de691bab6977" => :mavericks
    sha256 "9c85d35fa29c92a42d12c29c8093f13ad9450326a7b41983452eb8ec26b841c1" => :yosemite
    sha256 "8387e57aad3fd4d32cf21383866c02b5a7e352aca604dc5d483ac0017a7919cf" => :el_capitan
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
