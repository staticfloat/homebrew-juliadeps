# Based on https://github.com/Homebrew/homebrew/blob/a9a9f0f99d98828664e9c0ff3d0291caad18996c/Library/Formula/polarssl.rb
# Forked to support bottled shared libraries, which are not built upstream

class Mbedtls < Formula
  desc 'Cryptographic & SSL/TLS library'
  homepage 'https://tls.mbed.org/'
  url 'https://tls.mbed.org/download/mbedtls-2.1.2-apache.tgz'
  head 'https://github.com/ARMmbed/mbedtls.git'
  sha256 'ce57cb9085f976ffde945af7e8cec058a66ad181a96fd228fbcbc485213a7c58'

  depends_on "cmake" => :build

  bottle do
    root_url 'https://juliabottles.s3.amazonaws.com'
    cellar :any
    sha256 "218b924cdf514e7d627359638ef80444b39625cc84c16aa83fce0da6a9b2f6f2" => :mavericks
    sha256 "5f2608009ea5f41ce956f46d78bc2f0b5497c8c4b4ad175a52ca420281a5b94f" => :yosemite
    sha256 "d525b38898b923fb8db69ee8b883c1fb80691c0bdcc01e81080ab7689f21b239" => :el_capitan
  end

  def install
    # "Comment this macro to disable support for SSL 3.0"
    inreplace "include/mbedtls/config.h" do |s|
      s.gsub! "#define MBEDTLS_SSL_PROTO_SSL3", "//#define MBEDTLS_SSL_PROTO_SSL3"
    end

    system "cmake", "-DUSE_SHARED_MBEDTLS_LIBRARY=On .", *std_cmake_args  # Shared libraries that Julia needs aren't built by default
    system "make"
    system "make", "install"

    # Why does PolarSSL ship with a "Hello World" executable. Let's remove that.
    rm_f "#{bin}/hello"
  end

  test do
    (testpath/"testfile.txt").write("This is a test file")
    # Don't remove the space between the checksum and filename. It will break.
    expected_checksum = "e2d0fe1585a63ec6009c8016ff8dda8b17719a637405a4e23c0ff81339148249  testfile.txt"
    assert_equal expected_checksum, shell_output("#{bin}/generic_sum SHA256 testfile.txt").strip
  end
end
