require 'formula'

class Zeromq32 < Formula
  homepage 'http://www.zeromq.org/'
  url 'http://download.zeromq.org/zeromq-3.2.5.tar.gz'
  sha256 "09653e56a466683edb2f87ee025c4de55b8740df69481b9d7da98748f0c92124"

  bottle do
    root_url 'https://juliabottles.s3.amazonaws.com'
    cellar :any
    rebuild 1
    sha256 "ce1222bc5a71fa713c0ed79dd68b3de070e3bbada894583af035c75cdbcb1778" => :mavericks
    sha256 "6426b2ac1e017b6af8619872cb0b2ccd2d3f72cde05aff6efea199b3e87785aa" => :yosemite
    sha256 "8fb98b9f0552215a0adbb8be868736dcb0c98ccec9061e33d757f83333e0f757" => :el_capitan
    sha256 "36ef4cea5f51d0fc72f719b386d2d1767df84462716013435acf7581cf11f4ff" => :sierra
  end

  option :universal
  option 'with-pgm', 'Build with PGM extension'

  depends_on 'pkg-config' => :build
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
