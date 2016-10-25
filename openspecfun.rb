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
  depends_on "openlibm" if build.with? "openlibm"

  bottle do
    root_url 'https://juliabottles.s3.amazonaws.com'
    cellar :any
    rebuild 1
    sha256 "6184f63d70321cfa68508b92b989fe48fdde051f7b590081b7f17339cdf833d8" => :mavericks
    sha256 "695a26a6b6c36a39a84cbd91aec10af85109eb354b44597864371583ba5ad6f9" => :yosemite
    sha256 "059f263bdc5dbedfa652aa631d72780e7c6a5be81192258fa059aae1789c471d" => :el_capitan
    sha256 "27d4b863e0f764690c2aa35df7043ef7f819aba6a3613d7f57312c408fde27f7" => :sierra
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
