require 'formula'

class Fontconfig < Formula
  homepage 'http://fontconfig.org/'
  url 'http://fontconfig.org/release/fontconfig-2.10.95.tar.bz2'
  sha1 'f9f4a25b730a9c56f951db6fec639ddeeb92a9d4'

  option :universal

  depends_on 'staticfloat/juliadeps/freetype'
  depends_on 'staticfloat/juliadeps/pkg-config' => :build

  # Patch adapted from Macports patch for 2.9.0 defines sizeof based on __LP64__
  # Fixes universal builds but seems groovy enough to apply in all cases.
  # https://trac.macports.org/browser/trunk/dports/graphics/fontconfig/files/patch-check-arch-at-runtime.diff
  def patches; DATA; end

  def install
    ENV.universal_binary if build.universal?
    system "./configure", "--disable-dependency-tracking",
                          "--with-add-fonts=/Library/Fonts,~/Library/Fonts",
                          "--prefix=#{prefix}"
    system "make install"
  end
end