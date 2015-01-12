require 'formula'

class Icu4c < Formula
  homepage 'http://site.icu-project.org/'
  head "http://source.icu-project.org/repos/icu/icu/trunk/", :using => :svn
  url "http://download.icu-project.org/files/icu4c/54.1/icu4c-54_1-src.tgz"
  version "54.1"
  sha1 "8c752490bbf31cea26e20246430cee67d48abe34"

  bottle do
    root_url 'https://juliabottles.s3.amazonaws.com'
    cellar :any
    sha1 "24caf08505c6d27692086ad497d10f55583b6027" => :yosemite
    sha1 "7df4b2ebc22d145da0169367e4b137a00fff8703" => :mavericks
    sha1 "31e1ed46fa9b565ad2fcd758586a1ce91abbff8f" => :mountain_lion
  end

  keg_only :provided_by_osx, "OS X provides libicucore.dylib (but nothing else)."

  option :universal
  option :cxx11

  def install
    ENV.universal_binary if build.universal?
    ENV.cxx11 if build.cxx11?

    args = ["--prefix=#{prefix}", "--disable-samples", "--disable-tests", "--enable-static"]
    args << "--with-library-bits=64" if MacOS.prefer_64_bit?
    cd "source" do
      system "./configure", *args
      system "make"
      system "make", "install"
    end
  end

  test do
    system "#{bin}/gendict", "--uchars", "/usr/share/dict/words", "dict"
  end
end
