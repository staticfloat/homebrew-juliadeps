class RmathJulia < Formula
  desc "The standalone Rmath library patched to use the dSFMT RNG"
  homepage "https://github.com/JuliaLang/Rmath-julia"
  url "https://github.com/JuliaLang/Rmath-julia/archive/v0.1.tar.gz"
  version "0.1"
  sha256 "8ba59378273dea999f956cecf37d47723682f3a46b55ce76ec36a0ffdbe6c8f7"
  head "https://github.com/JuliaLang/Rmath-julia.git", :branch => "master"
  revision 1

  option "with-gcc", "Compile using GCC instead of Clang"

  depends_on 'gcc' => :build if "with-gcc"

  bottle do
    root_url 'https://juliabottles.s3.amazonaws.com'
    cellar :any
  end

  def install
    args = []
    if build.with? "gcc"
      args << "USEGCC=1"
    else
      args << "USECLANG=1"
    end

    lib.mkdir
    system "make", *args
    lib.install Dir["src/libRmath-julia.dylib"]
  end
end
