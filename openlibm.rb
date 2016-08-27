class Openlibm < Formula
  desc "High quality, system independent, portable, open source libm implementation"
  homepage "http://www.openlibm.org"
  url "https://github.com/JuliaLang/openlibm/archive/v0.5.3.tar.gz"
  version "0.5.3"
  sha256 "e86d001dfd05557e900e424bdc85024dbd5f00ad194d4607feb39c6f4d117512"
  head "https://github.com/JuliaLang/openlibm.git"

  bottle do
    root_url 'https://juliabottles.s3.amazonaws.com'
    cellar :any
    sha256 "f8e9385b667205fce607160791cdf2e2781876d009136308473694e40e18ddf6" => :yosemite
    sha256 "9051654487ab54730ead540d959ad9178cb4c1987442949b78718c0992ebaace" => :el_capitan
    sha256 "45bca6d71876814a8958320f5274158cf70b599ab9ee502a02de7e4a0a51f4d5" => :mavericks
  end

  def install
    lib.mkpath
    (lib/"pkgconfig").mkpath
    (include/"openlibm").mkpath

    system "make", "install", "prefix=."

    lib.install Dir["lib/*"].reject { |f| File.directory? f }
    (lib/"pkgconfig").install Dir["lib/pkgconfig/*"]
    (include/"openlibm").install Dir["include/openlibm/*"]
  end
end
