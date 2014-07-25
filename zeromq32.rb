require 'formula'

class Zeromq32 < Formula
  homepage 'http://www.zeromq.org/'
  url 'http://download.zeromq.org/zeromq-3.2.4.tar.gz'
  sha1 '08303259f08edd1faeac2e256f5be3899377135e'

  option :universal
  option 'with-pgm', 'Build with PGM extension'

  depends_on 'staticfloat/juliadeps/pkg-config' => :build
  depends_on 'libpgm'

  def install
    ENV.universal_binary if build.universal?
    args = ["--disable-dependency-tracking", "--prefix=#{prefix}"]
    
    # Use HB libpgm-5.2 because their internal 5.1 is b0rked.
    ENV['OpenPGM_CFLAGS'] = %x[pkg-config --cflags openpgm-5.2].chomp
    ENV['OpenPGM_LIBS'] = %x[pkg-config --libs openpgm-5.2].chomp
    args << "--with-system-pgm"

    system "./autogen.sh" if build.head?
    system "./configure", *args
    system "make"
    system "make install"
  end
end
