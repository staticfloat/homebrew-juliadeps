require "formula"

class Scs118 < Formula
  homepage 'https://github.com/cvxgrp/scs'
  url 'https://github.com/cvxgrp/scs/archive/v1.1.8.tar.gz'
  head 'https://github.com/cvxgrp/scs.git'
  sha256 '4249df60aa3c27d6b4d46a162a766d3e391f7771ef3a3a68edd5380176c3ae92'

  bottle do
    root_url 'https://juliabottles.s3.amazonaws.com'
    cellar :any
    sha256 "e1de987f1a1e0a3dadd1b8e160fd0b8ba67ea5630c83a97cc4fd71eacd03cd3d" => :mavericks
    sha256 "c895e43c4619b8f0ff8cfdddd79bf41bb9dae54ed81487591211bd1b4b13fe71" => :yosemite
    sha256 "ea4f3264c5fff0b8e65419119c0a1f40d9f055777d3aa120b677f32d7ba852d8" => :sierra
    sha256 "862356fc4324b5d22be02449e9049af92115349e9801ff82969d04d28363f7ad" => :el_capitan
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
