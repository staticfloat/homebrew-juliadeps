require "formula"

class Scs < Formula
  homepage 'https://github.com/cvxgrp/scs'
  url 'https://github.com/cvxgrp/scs/archive/v1.1.8.tar.gz'
  head 'https://github.com/cvxgrp/scs.git'
  sha256 '4249df60aa3c27d6b4d46a162a766d3e391f7771ef3a3a68edd5380176c3ae92'

  bottle do
    root_url 'https://juliabottles.s3.amazonaws.com'
    cellar :any
    rebuild 1
    sha256 "19038a11b540bf6d951d63b38f4762d5761d66c2140a59f515a62ae042f5d0a9" => :mavericks
    sha256 "742e7f8f875dc6182062e7b65f7ce04682192b9f6089d0429d0c9a7a7fef3754" => :yosemite
    sha256 "4e245c8b9a3c0eb955056be7718343f120af69b67b767a88e44e3430eb8331b0" => :el_capitan
    sha256 "d67e41f1d55d82fb984c6429e10e4dbb1074062d072f4dc0e33503f38b90069b" => :sierra
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
