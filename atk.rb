require 'formula'

class Atk < Formula
  desc 'GNOME accessibility toolkit'
  homepage 'http://library.gnome.org/devel/atk/'
  url 'https://download.gnome.org/sources/atk/2.18/atk-2.18.0.tar.xz'
  sha256 'ce6c48d77bf951083029d5a396dd552d836fff3c1715d3a7022e917e46d0c92b'

  bottle do
    root_url 'https://juliabottles.s3.amazonaws.com'
    cellar :any
    sha256 "5dd63c0c8e06420c0416842b03b0ba8d395e81a92dc28281b30bc0660f2c25e1" => :mavericks
    sha256 "7ec079fb33d286c1c44134bc71d986118570de730894cd5cd22ba4b7ceb067e2" => :yosemite
    sha256 "0e1ed39f74e96dd838371d026b3b888d2dcda2dc5bb8c4443be71ba25a3c5067" => :el_capitan
  end

  depends_on 'staticfloat/juliadeps/pkg-config' => :build
  depends_on 'staticfloat/juliadeps/glib'
  depends_on 'staticfloat/juliadeps/gobject-introspection'

  option :universal

  def install
    ENV.universal_binary if build.universal?
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--enable-introspection=yes"
    system "make"
    system "make install"
  end
end
