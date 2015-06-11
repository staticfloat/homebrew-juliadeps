require "formula"

class Harfbuzz < Formula
  homepage "http://www.freedesktop.org/wiki/Software/HarfBuzz"
  url "http://www.freedesktop.org/software/harfbuzz/release/harfbuzz-0.9.37.tar.bz2"
  sha256 "255f3b3842dead16863d1d0c216643d97b80bfa087aaa8fc5926da24ac120207"

  bottle do
    root_url 'https://juliabottles.s3.amazonaws.com'
    cellar :any
    sha1 "6a768391ea765c78d4a6d39ccad701f68f067b65" => :yosemite
    sha1 "fb56592f5d2cd5f70d6d0dacb3340e193c76f7c3" => :mavericks
    sha1 "c4c61e3e044ea550f089f3e3a1bafc19c39d8bd4" => :mountain_lion
  end

  depends_on "staticfloat/juliadeps/pkg-config" => :build
  depends_on "staticfloat/juliadeps/glib"
  depends_on "staticfloat/juliadeps/cairo"
  depends_on "staticfloat/juliadeps/icu4c" => :recommended
  depends_on "staticfloat/juliadeps/freetype"

  def install
    args = %W[--disable-dependency-tracking --prefix=#{prefix}]
    args << "--with-icu" if build.with? "icu4c"
    system "./configure", *args
    system "make install"
  end
end
