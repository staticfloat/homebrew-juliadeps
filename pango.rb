require 'formula'

class Pango < Formula
  homepage 'http://www.pango.org/'
  url "http://ftp.gnome.org/pub/GNOME/sources/pango/1.36/pango-1.36.8.tar.xz"
  sha256 "18dbb51b8ae12bae0ab7a958e7cf3317c9acfc8a1e1103ec2f147164a0fc2d07"

  depends_on 'staticfloat/juliadeps/pkg-config' => :build
  depends_on 'xz' => :build
  depends_on 'fontconfig'
  depends_on 'staticfloat/juliadeps/glib'
  depends_on 'staticfloat/juliadeps/harfbuzz'
  depends_on 'staticfloat/juliadeps/cairo'
  depends_on 'staticfloat/juliadeps/gobject-introspection'

  bottle do
    root_url 'https://juliabottles.s3.amazonaws.com'
    cellar :any
    sha1 "6292e46564a5bf366a9e239488d0bf8226624222" => :mountain_lion
    sha1 "86b5f2da6965681bb41ddd9c8bd6961ee995cc74" => :yosemite
    sha1 "3607af9e69211378fa8772c6149e8eeb6bd9c3da" => :mavericks
  end

  option :universal

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
      --disable-silent-rules
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

  test do
    system "#{bin}/pango-querymodules", "--version"
  end
end
