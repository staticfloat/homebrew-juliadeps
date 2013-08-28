require 'formula'

# Upstream project has requested we use a mirror as the main URL
# https://github.com/mxcl/homebrew/pull/21419
class Xz < Formula
  homepage 'http://tukaani.org/xz/'
  url 'http://fossies.org/linux/misc/xz-5.0.5.tar.gz'
  mirror 'http://tukaani.org/xz/xz-5.0.5.tar.gz'
  sha256 '5dcffe6a3726d23d1711a65288de2e215b4960da5092248ce63c99d50093b93a'

  option :universal

  bottle do
    root_url 'http://juliabottles.s3-website-us-east-1.amazonaws.com/bottles'
    cellar :any
    sha1 '9d9a6e6c7b8fb6050bb4698957d570f2e3089c7a' => :mountain_lion
    sha1 '9d9a6e6c7b8fb6050bb4698957d570f2e3089c7a' => :lion
    sha1 '9d9a6e6c7b8fb6050bb4698957d570f2e3089c7a' => :snow_leopard
  end

  def install
    ENV.universal_binary if build.universal?
    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make install"
  end
end
