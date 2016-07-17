class RmathJulia < Formula
  desc "The standalone Rmath library patched to use the dSFMT RNG"
  homepage "https://github.com/JuliaLang/Rmath-julia"
  url "https://github.com/JuliaLang/Rmath-julia/archive/v0.1.tar.gz"
  version "0.1"
  sha256 "8ba59378273dea999f956cecf37d47723682f3a46b55ce76ec36a0ffdbe6c8f7"
  head "https://github.com/JuliaLang/Rmath-julia.git", :branch => "master"

  option "with-clang", "Compile using Clang instead of GCC"

  depends_on :gcc => :build unless "with-clang"

  bottle do
    root_url 'https://juliabottles.s3.amazonaws.com'
    cellar :any
    sha256 "d02827639cdd69a3eebf76665bbe1c812a6ee6e20d50e3df5046eafe221f307b" => :mavericks
    sha256 "32d8595c2c672c8065de7e6d3e304daaef1967333d101e39fcf3ed9cd78d6a92" => :yosemite
    sha256 "7ecafc948e6bb94335e0a626b86e5ab588435af4420c16f40ff0b326e6f05cb4" => :el_capitan
  end

  def install
    args = []
    args << "USECLANG=1" if build.with? "clang"

    lib.mkdir
    system "make", *args
    lib.install Dir["src/libRmath-julia.dylib"]
  end
end
