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
