require "formula"

class Scs < Formula
  homepage "https://github.com/cvxgrp/scs"
  url "https://github.com/cvxgrp/scs/archive/v1.1.5.tar.gz"
  head "https://github.com/cvxgrp/scs.git"
  sha1 "fd6c7a1a5bd428f61f9e27e0e194bff8fd43d267"
  revision 1

  bottle do
    root_url 'https://juliabottles.s3.amazonaws.com'
    cellar :any
    sha256 "eba963c11b7b36b719f92e759b32f82092838336fb2217cf19925399a1348683" => :yosemite
    sha256 "f8c9b6148fcef9883bc100391451ad46f30d8517e5d8f218a49c98f629f5ef21" => :mavericks
    sha256 "3c016c1a9b540eefa726907ac8e4d046518ab6e113fc1e8d9a05ee3bfc066dc8" => :mountain_lion
  end

  def install
    # Make 32-bit build
    ENV['CFLAGS'] = "-DDLONG -DCOPYAMATRIX -DLAPACK_LIB_FOUND"
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
