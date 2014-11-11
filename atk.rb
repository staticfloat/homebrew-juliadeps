require 'formula'

class Atk < Formula
  homepage 'http://library.gnome.org/devel/atk/'
  url 'http://ftp.gnome.org/pub/gnome/sources/atk/2.12/atk-2.12.0.tar.xz'
  sha256 '48a8431974639c5a59c24fcd3ece1a19709872d5dfe78907524d9f5e9993f18f'

  bottle do
    root_url 'https://juliabottles.s3.amazonaws.com'
    cellar :any
    sha1 'ddd9b90148eb8155d06c4d112e0e56d0fbeaefcf' => :lion
    sha1 '67ae684950cb745daaeee5e24d4b5dd0df2208cd' => :mavericks
    sha1 'b45b6f59a529db6b8c35253c96aa0e86a708b8e6' => :mountain_lion
    sha1 "1498a223a23f61dc30677c4db8c1f5d50c8174a2" => :yosemite
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
