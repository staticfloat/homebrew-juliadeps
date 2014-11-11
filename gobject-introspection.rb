require 'formula'

class GobjectIntrospection < Formula
  homepage 'http://live.gnome.org/GObjectIntrospection'
  url 'http://ftp.gnome.org/pub/GNOME/sources/gobject-introspection/1.40/gobject-introspection-1.40.0.tar.xz'
  sha256 '96ea75e9679083e7fe39a105e810e2ead2d708abf189a5ba420bfccfffa24e98'

  bottle do
    root_url 'https://juliabottles.s3.amazonaws.com'
    cellar :any
    revision 1
    sha1 'fd510e783ec1dc5f6e6be61b573b2090eea5d2f1' => :lion
    sha1 '141755831b49c7e420e27cae25f473a39f954a4c' => :mavericks
    sha1 'bfbaae3518258e5add6deb27b0617317c4aa67e2' => :mountain_lion
    sha1 "de70d9af6fb8a8b545c0d809ab329fa09b665a00" => :yosemite
  end

  option :universal
  option 'with-tests', 'Run tests in addition to the build (requires cairo)'

  depends_on 'staticfloat/juliadeps/pkg-config' => :build
  depends_on 'staticfloat/juliadeps/glib'
  depends_on 'libffi'
  # To avoid: ImportError: dlopen(./.libs/_giscanner.so, 2): Symbol not found: _PyList_Check
  depends_on :python => :build
  depends_on 'staticfloat/juliadeps/cairo' => :build if build.with? 'tests'

  # Allow tests to execute on OS X (.so => .dylib)
  patch do
    url "https://gist.githubusercontent.com/krrk/6958869/raw/de8d83009d58eefa680a590f5839e61a6e76ff76/gobject-introspection-tests.patch"
    sha1 "1f57849db76cd2ca26ddb35dc36c373606414dfc"
  end if build.with? "tests"

  def install
    ENV['GI_SCANNER_DISABLE_CACHE'] = 'true'
    ENV.universal_binary if build.universal?
    inreplace 'giscanner/transformer.py', '/usr/share', HOMEBREW_PREFIX/'share'
    inreplace 'configure' do |s|
      s.change_make_var! 'GOBJECT_INTROSPECTION_LIBDIR', HOMEBREW_PREFIX/'lib'
    end

    args = %W[--disable-dependency-tracking --prefix=#{prefix}]
    args << "--with-cairo" if build.with? "tests"

    system "./configure", *args
    system "make"
    system "make", "check" if build.with? "tests"
    system "make", "install"
  end
end
