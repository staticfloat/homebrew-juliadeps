require "formula"

class Scs < Formula
  homepage 'https://github.com/cvxgrp/scs'
  url 'https://github.com/cvxgrp/scs/archive/v1.2.6.tar.gz'
  head 'https://github.com/cvxgrp/scs.git'
  sha256 'b4bebb43a1257b6e88a5f97c855c0559d6c8a8c0548d3156fc5a28d82bb9533f'

  bottle do
    root_url 'https://juliabottles.s3.amazonaws.com'
    cellar :any
    sha256 "d0e82e6519b697f93b4f079f023f0a7d9e4abf59b16ad6b03930573453dc6a96" => :mavericks
    sha256 "bdfbfd8f7497476a867538ad92624c9417c0453915cb4b273d7154b1005cef60" => :sierra
    sha256 "408df13d78f4786c609563ed1fa9e8ba25902a188267c96606c4a91e86ce9980" => :el_capitan
    sha256 "7e1535a472f31879f24926080900242437235ae57396a8d7e468dbaf311f7e96" => :yosemite
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
