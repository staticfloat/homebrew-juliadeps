require 'formula'

class Portaudio < Formula
  homepage 'http://www.portaudio.com'

  stable do
    url 'http://www.portaudio.com/archives/pa_stable_v19_20111121.tgz'
    sha1 'f07716c470603729a55b70f5af68f4a6807097eb'

    # Fix PyAudio compilation on Lion
    patch :p0 do
      url "https://trac.macports.org/export/94150/trunk/dports/audio/portaudio/files/patch-include__pa_mac_core.h.diff"
      mirror "https://raw.githubusercontent.com/sakuro/macports/9ee0b7dd6045a3967348638a228bc1a658bcaa3f/audio/portaudio/files/patch-include__pa_mac_core.h.diff"
      sha1 "28188dfb6a5438a050fccb70331751a40e33447d"
    end if MacOS.version >= :lion
  end

  head 'https://subversion.assembla.com/svn/portaudio/portaudio/trunk/', :using => :svn

  bottle do
    root_url 'https://juliabottles.s3.amazonaws.com'
    cellar :any
    sha1 '7525cd47924d4adb45be600c936d2abc77c2fa46' => :lion
    sha1 '316130397237ff3fb01cd866f0e6e151d63e0f5d' => :mavericks
    sha1 'bdeb69787a9983f61b8239cba74face75a1dec37' => :mountain_lion
    sha1 "876acc12c9699e12399c96c6bc3af57c200e97d1" => :yosemite
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
