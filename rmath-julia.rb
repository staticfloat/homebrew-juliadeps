class RmathJulia < Formula
  homepage "https://github.com/JuliaLang/Rmath-julia"
  url "https://github.com/JuliaLang/Rmath-julia/archive/v0.1.tar.gz"
  version "0.1"
  sha1 "c1e2fb49a12391e71c49d48e9d8e09ea6143f3ec"

  def install
    system "make"
    lib.install "src/libRmath-julia.dylib"
    include.install Dir["include/*"]
  end
end
