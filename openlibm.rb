class Openlibm < Formula
  desc "High quality, system independent, portable, open source libm implementation"
  homepage "http://www.openlibm.org"
  url "https://github.com/JuliaLang/openlibm/archive/v0.5.3.tar.gz"
  version "0.5.3"
  sha256 "e86d001dfd05557e900e424bdc85024dbd5f00ad194d4607feb39c6f4d117512"
  head "https://github.com/JuliaLang/openlibm.git"

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
