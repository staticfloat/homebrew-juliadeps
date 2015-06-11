require 'formula'

class Graphviz < Formula
  homepage 'http://graphviz.org/'
  url 'http://graphviz.org/pub/graphviz/stable/SOURCES/graphviz-2.38.0.tar.gz'
  sha1 '053c771278909160916ca5464a0a98ebf034c6ef'
  revision 1

  bottle do
    root_url 'https://juliabottles.s3.amazonaws.com'
    cellar :any
    sha1 "794aa82d238050ac242d8d7cc31609f104ba4e59" => :yosemite
    sha1 "276272b654eb1a357ef063a9f70bc9c137584fac" => :mavericks
    sha1 "6fddf51b6d5f659aa34cc07df0710d36b205b370" => :mountain_lion
  end

  # To find Ruby and Co.
  env :std

  option :universal

  depends_on "libpng"
  depends_on "libtool"

  depends_on 'staticfloat/juliadeps/pkg-config' => :build
  depends_on 'staticfloat/juliadeps/pango'
  depends_on 'swig' if build.with? "bindings"
  depends_on 'gts' => :optional
  depends_on "librsvg" => :optional
  depends_on "staticfloat/juliadeps/freetype" => :optional
  depends_on :x11 if build.with? "x"
  depends_on :xcode => :build if build.with? "app"

  fails_with :clang do
    build 318
  end

  patch :p0 do
    url "https://trac.macports.org/export/103168/trunk/dports/graphics/graphviz/files/patch-project.pbxproj.diff"
    sha1 "b242fb8fa81489dd16830e5df6bbf5448a3874d5"
  end

  def install
    ENV.universal_binary if build.universal?
    args = ["--disable-debug",
            "--disable-dependency-tracking",
            "--prefix=#{prefix}",
            "--without-qt",
            "--with-quartz"]
    args << "--with-gts" if build.with? 'gts'
    args << "--disable-swig" if build.without? "bindings"
    args << "--without-freetype2" if build.without? "freetype"
    args << "--without-x"
    args << "--without-rsvg" if build.without? "librsvg"

    system "./configure", *args
    system "make install"

    if build.with? "app"
      cd "macosx" do
        xcodebuild "-configuration", "Release", "SYMROOT=build", "PREFIX=#{prefix}", "ONLY_ACTIVE_ARCH=YES"
      end
      prefix.install "macosx/build/Release/Graphviz.app"
    end

    (bin+'gvmap.sh').unlink
  end

  test do
    (testpath/'sample.dot').write <<-EOS.undent
    digraph G {
      a -> b
    }
    EOS

    system "#{bin}/dot", "-Tpdf", "-o", "sample.pdf", "sample.dot"
  end
end
