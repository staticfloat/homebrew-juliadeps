require "formula"

class Scs < Formula
  homepage "https://github.com/cvxgrp/scs"
  url "https://github.com/cvxgrp/scs/archive/v1.1.5.tar.gz"
  head "https://github.com/cvxgrp/scs.git"
  sha1 "fd6c7a1a5bd428f61f9e27e0e194bff8fd43d267"
  revision 2

  bottle do
    root_url 'https://juliabottles.s3.amazonaws.com'
    cellar :any
    sha256 "e14907aa969fe3ff39d536754df0689e8359532a04085b89c7173ede5aadeec3" => :mountain_lion
    sha256 "8e4dbc87cbc1baa283327885692333586e76cf71cad12751629f46f7334a6cb7" => :yosemite
    sha256 "9e7aebb57823a0133faeb927f59aca7231595e2b8eac77cd185f43d7388128bc" => :mavericks
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
