class RmathJulia < Formula
  desc "The standalone Rmath library patched to use the dSFMT RNG"
  homepage "https://github.com/JuliaLang/Rmath-julia"
  url "https://github.com/JuliaLang/Rmath-julia/archive/v0.1.tar.gz"
  version "0.1"
  sha256 "8ba59378273dea999f956cecf37d47723682f3a46b55ce76ec36a0ffdbe6c8f7"
  head "https://github.com/JuliaLang/Rmath-julia.git", :branch => "master"
  revision 1

  option "with-gcc", "Compile using GCC instead of Clang"

  depends_on 'gcc' => :build if build.with? "gcc"

  bottle do
    root_url 'https://juliabottles.s3.amazonaws.com'
    cellar :any
    rebuild 1
    sha256 "5521eae6a79f3d43204e997e8e8ba32d5f7f9ff47093308e9bfa6f4ac273ff81" => :mavericks
    sha256 "c69b91e01846a074677666b6218cebdcce21108375313198cbf46ca3af6b13bd" => :yosemite
    sha256 "807e4512f34278330e0532c0aafd98917582a0b293659ff3a051f01d10a508cb" => :el_capitan
    sha256 "a7634f8043d1c20b5dca773d9de42c8dac92c039be3dc23c0a20a3b1cc6a20a0" => :sierra
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
