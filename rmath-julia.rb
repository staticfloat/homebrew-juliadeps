class RmathJulia < Formula
  desc "Nowadays just used for testing Homebrew on formulae with old bottles"
  homepage "https://github.com/JuliaLang/Rmath-julia"
  url "https://github.com/JuliaLang/Rmath-julia/archive/v0.1.tar.gz"
  version "0.1"
  sha256 "8ba59378273dea999f956cecf37d47723682f3a46b55ce76ec36a0ffdbe6c8f7"
  head "https://github.com/JuliaLang/Rmath-julia.git", :branch => "master"
  revision 1

  depends_on 'gcc' => :build if build.with? "gcc"

  bottle do
    root_url 'https://juliabottles.s3.amazonaws.com'
    cellar :any
    sha256 "5521eae6a79f3d43204e997e8e8ba32d5f7f9ff47093308e9bfa6f4ac273ff81" => :lion
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
