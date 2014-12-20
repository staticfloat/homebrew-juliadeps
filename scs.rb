require "formula"

class Scs < Formula
  homepage "https://github.com/cvxgrp/scs"
  url "https://github.com/cvxgrp/scs/archive/v1.0.7.tar.gz"
  head "https://github.com/cvxgrp/scs.git"
  sha1 "fac3869989770f60d451fe4bd3c14afb7f73ae9f"
  revision 1

  bottle do
    root_url 'https://juliabottles.s3.amazonaws.com'
    cellar :any
    sha1 "f91d0d48c370f38bc98cf3e0943ec31aba898ee5" => :yosemite
    sha1 "7d6dc861d422fae60b152e11ec6182083e4aeec2" => :mavericks
    sha1 "e75ff42a4e7d15450783cd17fafc22cf9d151491" => :mountain_lion
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
