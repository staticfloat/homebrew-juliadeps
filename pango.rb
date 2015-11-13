require 'formula'

class Pango < Formula
  homepage "http://www.pango.org/"
  url "http://ftp.gnome.org/pub/GNOME/sources/pango/1.38/pango-1.38.1.tar.xz"
  sha256 '1320569f6c6d75d6b66172b2d28e59c56ee864ee9df202b76799c4506a214eb7'
  revision 1

  head do
    url 'https://git.gnome.org/browse/pango'

    depends_on 'automake' => :build
    depends_on 'autoconf' => :build
    depends_on 'libtool' => :build
    depends_on 'gtk-doc' => :build
  end

  bottle do
    root_url 'https://juliabottles.s3.amazonaws.com'
    cellar :any
    sha256 "8de8a2fa2f1588d6873c036a4a90418352a006eaa74a1ca6a9ad540b0514825c" => :mavericks
    sha256 "0058ff1f79b74a912388dd4a31a6020f64cbdd5b6e08b7424a7214d32940826e" => :yosemite
    sha256 "b5b15406065b131bfa2a163eb6caa58e57404a4d60b45943f14dbd0bf777bffa" => :el_capitan
  end

  option :universal

  depends_on 'staticfloat/juliadeps/pkg-config' => :build
  depends_on 'staticfloat/juliadeps/glib'
  depends_on 'staticfloat/juliadeps/cairo'
  depends_on 'staticfloat/juliadeps/harfbuzz'
  depends_on 'staticfloat/juliadeps/fontconfig'
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
      --without-xft
    ]

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
