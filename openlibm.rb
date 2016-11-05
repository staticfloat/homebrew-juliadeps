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
    rebuild 1
    sha256 "142b7f0eb1486c995fff0a5a567ab123956f5c28993b3ef09e6874001a8d2287" => :mavericks
    sha256 "2bae7ef96f9de269387bce991ee9a203577e9448a6fbe5aab89bcd7edb3b95ed" => :yosemite
    sha256 "565df4b24280d2a025009ee7486c942b15841d515bc8913b428bf2073bb24053" => :el_capitan
    sha256 "43d79fa9f82e93048183eb2e5ac8d5ee794193d4f4f70eb3b446ebe318327699" => :sierra
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
