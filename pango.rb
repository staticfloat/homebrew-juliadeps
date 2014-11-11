require 'formula'

class Pango < Formula
  homepage 'http://www.pango.org/'
  url 'http://ftp.gnome.org/pub/GNOME/sources/pango/1.36/pango-1.36.5.tar.xz'
  sha256 'be0e94b2e5c7459f0b6db21efab6253556c8f443837200b8736d697071276ac8'

  depends_on 'staticfloat/juliadeps/pkg-config' => :build
  depends_on 'xz' => :build
  depends_on 'staticfloat/juliadeps/glib'
  depends_on 'staticfloat/juliadeps/harfbuzz'
  depends_on 'staticfloat/juliadeps/cairo'
  depends_on 'staticfloat/juliadeps/fontconfig'
  depends_on 'staticfloat/juliadeps/gobject-introspection'

  bottle do
    root_url 'https://juliabottles.s3.amazonaws.com'
    cellar :any
    revision 1
    sha1 '196f8f3079d1e8cc824c610e07dcd1b400b45b3a' => :lion
    sha1 '507fea3b9bf90ccfa895f245867e0817d250d925' => :mavericks
    sha1 '3cb8b0ce02baf79ce2c8ff6fc2cfd91408a754ff' => :mountain_lion
    sha1 "f57058a2d16f33cd6cb2ad029a0a18b8f636138a" => :yosemite
  end

  fails_with :llvm do
    build 2326
    cause "Undefined symbols when linking"
  end

  def post_install
    if (Tab.for_formula self).poured_from_bottle
      # Fixup pango module paths
      inreplace prefix+'etc/pango/pango.modules', %r[.*/(lib/pango/[\d\.]+/modules/.*)], prefix+'\1'

      # Tell pango where to find pango.modules
      (rm etc+'pango/pangorc') if File.exist? etc+'pango/pangorc'
      (etc+'pango/pangorc').write <<-EOS.undent
      #
      # pangorc file to setup proper ModuleFiles path
      #
      [Pango]
      ModulesPath = #{lib}/1.8.0/modules/
      EOS
    end
  end

  def install
    args = %W[
      --disable-dependency-tracking
      --prefix=#{prefix}
      --enable-man
      --with-html-dir=#{share}/doc
      --enable-introspection
    ]

    # We always build without x
    args << '--without-xft'

    system "./configure", *args
    system "make"
    system "make install"
  end

  def test
    system "#{bin}/pango-querymodules", "--version"
  end
end
