require 'formula'

class Pango < Formula
  homepage "http://www.pango.org/"
  url "http://ftp.gnome.org/pub/GNOME/sources/pango/1.36/pango-1.36.8.tar.xz"
  sha256 "18dbb51b8ae12bae0ab7a958e7cf3317c9acfc8a1e1103ec2f147164a0fc2d07"

  head do
    url 'https://git.gnome.org/browse/pango'

    depends_on 'automake' => :build
    depends_on 'autoconf' => :build
    depends_on 'libtool' => :build
    depends_on 'gtk-doc' => :build
  end

  bottle do
    revision 1
    sha1 "b30d81e5b4b90792e14aa02b273fcf93e9675fc7" => :yosemite
    sha1 "eb30e96c1d896cd8fc7e1053513b3e298645c9af" => :mavericks
    sha1 "ea288645c2ca58b4addf29c0140fb3ecec6ea3ab" => :mountain_lion
  end

  option :universal

  depends_on 'staticfloat/juliadeps/pkg-config' => :build
  depends_on 'staticfloat/juliadeps/glib'
  depends_on 'staticfloat/juliadeps/cairo'
  depends_on 'staticfloat/juliadeps/harfbuzz'
  depends_on 'staticfloat/juliadeps/fontconfig'
  depends_on :x11 => :recommended
  depends_on 'staticfloat/juliadeps/gobject-introspection'

  fails_with :llvm do
    build 2326
    cause "Undefined symbols when linking"
  end

  def install
    ENV.universal_binary if build.universal?

    args = %W[
      --disable-dependency-tracking
      --disable-silent-rules
      --prefix=#{prefix}
      --enable-man
      --with-html-dir=#{share}/doc
      --enable-introspection=yes
    ]

    if build.without? "x11"
      args << '--without-xft'
    else
      args << '--with-xft'
    end

    system "./autogen.sh" if build.head?
    system "./configure", *args
    system "make"
    system "make install"
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

  test do
    system "#{bin}/pango-querymodules", "--version"
  end
end
