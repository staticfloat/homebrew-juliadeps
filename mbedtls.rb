# Based on https://github.com/Homebrew/homebrew/blob/a9a9f0f99d98828664e9c0ff3d0291caad18996c/Library/Formula/polarssl.rb
# Forked to support bottled shared libraries, which are not built upstream

class Mbedtls < Formula
  desc "Cryptographic & SSL/TLS library"
  homepage "https://tls.mbed.org/"
  url "https://tls.mbed.org/download/mbedtls-2.1.1-apache.tgz"
  sha256 "8f25b6f156ae5081e91bcc58b02455926d9324035fe5f7028a6bb5bc0139a757"
  head "https://github.com/ARMmbed/mbedtls.git"

  depends_on "cmake" => :build

  bottle do
    root_url 'https://juliabottles.s3.amazonaws.com'
    cellar :any
    sha256 "b88d0e596a904925c4065f94421515cfd41124f6915fbdb66af4a4a7865b4e66" => :mountain_lion
    sha256 "255a3704b37a7a151b9666a331e3be470193fea97ea629c3e85776b751046216" => :mavericks
    sha256 "631606cd2edc6b3aa1133f346367081a87cf0472e7f54ed1c983f083bebc686c" => :yosemite
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
