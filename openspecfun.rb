class Openspecfun < Formula
  desc "Library of Bessel, Airy, and error functions of complex arguments"
  homepage "https://github.com/JuliaLang/openspecfun"
  url "https://github.com/JuliaLang/openspecfun/archive/v0.5.3.tar.gz"
  version "0.5.3"
  sha256 "1505c7a45f9f39ffe18be36f7a985cb427873948281dbcd376a11c2cd15e41e7"
  head "https://github.com/JuliaLang/openspecfun.git"

  option "with-openlibm", "Compile using OpenLibm instead of the system's libm"
  option "with-gcc", "Compile using GCC instead of Clang"

  # The option with-gcc dictates whether the C compiler is GCC. GCC is needed
  # anyway because it includes gfortran, which apparently is no longer its own
  # Homebrew formula.
  depends_on "gcc" => :build
  depends_on "openlibm" if "with-openlibm"

  bottle do
    root_url 'https://juliabottles.s3.amazonaws.com'
    cellar :any
    sha256 "c67bd279ef2df2d23fbfcdf4b5d3f7d2435ae17ad443594183083edd5168246f" => :mavericks
    sha256 "5407ae2c6ab9e194aaa2e064b27e0428985db14ac4423d70ec2c1397ca4c57dc" => :yosemite
    sha256 "0ec3363a691148d85c038f293152fb760aadf68e2ded1eb31d3ab72fa7e1d02a" => :el_capitan
  end

  def install
    args = []
    args << "USEGCC=1" if build.with? "gcc"
    args << "USE_OPENLIBM=1" if build.with? "openlibm"

    lib.mkpath
    include.mkpath

    system "make", "install", "prefix=.", *args

    lib.install Dir["lib/*"]
    include.install Dir["include/*"]
  end
end
