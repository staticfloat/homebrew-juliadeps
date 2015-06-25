require "formula"

class Scs < Formula
  homepage "https://github.com/cvxgrp/scs"
  url "https://github.com/cvxgrp/scs/archive/v1.1.5.tar.gz"
  head "https://github.com/cvxgrp/scs.git"
  sha1 "fd6c7a1a5bd428f61f9e27e0e194bff8fd43d267"

  bottle do
    root_url 'https://juliabottles.s3.amazonaws.com'
    cellar :any
    sha256 "d2487ea9a1c980e12ca69d6ff6d7e33de99626b11b7fa14ac807d4f2e09519de" => :mountain_lion
    sha256 "b81adaa6fad59b94a72f0f6031aa5e93d5fabb4814bffd594fc17a630e65896a" => :mavericks
    sha256 "d7c19b2d4a6db27320ca984b58b8f1e4eecf060e37f478dcc437ab003fa2dc32" => :yosemite
  end

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
