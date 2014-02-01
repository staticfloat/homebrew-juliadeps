require 'formula'

class Zeromq32 < Formula
  homepage 'http://www.zeromq.org/'
  url 'http://download.zeromq.org/zeromq-3.2.4.tar.gz'
  sha1 '08303259f08edd1faeac2e256f5be3899377135e'

  bottle do
    root_url 'http://archive.org/download/julialang/bottles'
    cellar :any
    sha1 '0f7adbef8efc7ef91cbf96a21de86124d8e283c4' => :snow_leopard_or_later
  end

  option :universal
  option 'with-pgm', 'Build with PGM extension'

  depends_on 'staticfloat/juliadeps/pkg-config' => :build
  depends_on 'libpgm' if build.include? 'with-pgm'

  def install
    ENV.universal_binary if build.universal?

    args = ["--disable-dependency-tracking", "--prefix=#{prefix}"]
    if build.include? 'with-pgm'
      # Use HB libpgm-5.2 because their internal 5.1 is b0rked.
      ENV['OpenPGM_CFLAGS'] = %x[pkg-config --cflags openpgm-5.2].chomp
      ENV['OpenPGM_LIBS'] = %x[pkg-config --libs openpgm-5.2].chomp
      args << "--with-system-pgm"
    end

    system "./autogen.sh" if build.head?
    system "./configure", *args
    system "make"
    system "make install"
  end
end
