require 'formula'

class Zeromq32 < Formula
  homepage 'http://www.zeromq.org/'
  url 'http://download.zeromq.org/zeromq-3.2.5.tar.gz'

  bottle do
    root_url 'https://juliabottles.s3.amazonaws.com'
    cellar :any
    sha256 "2385b1c76c5d0db6b9cb34e9ce7e14ebafe02860a7ee8a4db12204172f1adc62" => :mavericks
    sha256 "d26aae3f53183bf32e0baab81d710eb98002e297ae57b04d05506fb6f86b68c4" => :yosemite
    sha256 "052c0e863530a6b261d08b1602d474cf993c7c2081586914cf21f6678958b47f" => :el_capitan
  end

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
