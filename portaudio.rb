require 'formula'

class Portaudio < Formula
  homepage 'http://www.portaudio.com'

  stable do
    url 'http://www.portaudio.com/archives/pa_stable_v19_20111121.tgz'
    sha256 '9c26d1330d506496789edafe55b0386f20d83c4aa2c0e3f81fbeb0f114ab1b99'
  end

  head 'https://subversion.assembla.com/svn/portaudio/portaudio/trunk/', :using => :svn

  bottle do
    root_url 'https://juliabottles.s3.amazonaws.com'
    cellar :any
    sha1 '316130397237ff3fb01cd866f0e6e151d63e0f5d' => :mavericks
    sha1 "876acc12c9699e12399c96c6bc3af57c200e97d1" => :yosemite
    sha256 "4a7772783ae36d803172d15a5356bb821991ff4f47580dd1fe2b7dce8cded984" => :el_capitan
  end

  depends_on 'staticfloat/juliadeps/pkg-config' => :build

  option :universal

  fails_with :llvm do
    build 2334
  end

  def install
    ENV.universal_binary if build.universal?

    args = [ "--prefix=#{prefix}",
             "--disable-debug",
             "--disable-dependency-tracking",
             # portaudio builds universal unless told not to
             "--enable-mac-universal=#{build.universal? ? 'yes' : 'no'}" ]

    system "./configure", *args
    system "make install"

    # Need 'pa_mac_core.h' to compile PyAudio
    include.install "include/pa_mac_core.h"
  end
end
