class Openlibm < Formula
  desc "High quality, system independent, portable, open source libm implementation"
  homepage "http://www.openlibm.org"
  url "https://github.com/JuliaLang/openlibm/archive/v0.5.2.tar.gz"
  version "0.5.2"
  sha256 "f394c90426356c8911333def8cee94971492a94ca94578e61ad857913c80122c"
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
