require 'formula'

class Pango < Formula
  homepage 'http://www.pango.org/'
  url 'http://ftp.gnome.org/pub/GNOME/sources/pango/1.34/pango-1.34.1.tar.xz'
  sha256 '1aea30df34a8ae4fcce71afd22aa5b57224b52916d46e3ea81ff9f1eb130e64c'

  bottle do
    root_url 'http://archive.org/download/julialang/bottles'
    cellar :any
    sha1 '9f6fe108b836d2c02f0bb2da9ab0d520599582dd' => :mountain_lion
    sha1 '9f6fe108b836d2c02f0bb2da9ab0d520599582dd' => :lion
    sha1 '9f6fe108b836d2c02f0bb2da9ab0d520599582dd' => :snow_leopard
  end

  depends_on 'staticfloat/juliadeps/pkg-config' => :build
  depends_on 'staticfloat/juliadeps/xz' => :build
  depends_on 'staticfloat/juliadeps/glib'
  depends_on 'staticfloat/juliadeps/harfbuzz'

  # The Cairo library shipped with Lion contains a flaw that causes Graphviz
  # to segfault. See the following ticket for information:
  #   https://trac.macports.org/ticket/30370
  # We depend on our cairo on all platforms for consistency
  depends_on 'staticfloat/juliadeps/cairo'

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
      --disable-introspection
    ]

    if build.include? 'without-x'
      args << '--without-xft'
    else
      args << '--with-xft'
    end

    system "./configure", *args
    system "make"
    system "make install"
  end

  def test
    system "#{bin}/pango-querymodules", "--version"
  end
end
