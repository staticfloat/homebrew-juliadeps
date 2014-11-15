require 'formula'

class Hwloc < Formula
  homepage 'http://www.open-mpi.org/projects/hwloc/'
  url "http://www.open-mpi.org/software/hwloc/v1.9/downloads/hwloc-1.9.tar.bz2"
  sha1 "99646446502e0f9952170bf1082be63361d99b6d"

  bottle do
    root_url 'https://juliabottles.s3.amazonaws.com'
    cellar :any
    sha1 "560982226130908dfb6e715c02c28459e7b81c60" => :mountain_lion
    sha1 "7e9351ef9e1553bdf2931a6dc972e4c1e7327679" => :mavericks
    sha1 "737942aee6397af2f566c0a4f3941f242f84bd25" => :yosemite
  end

  depends_on 'staticfloat/juliadeps/pkg-config' => :build
  depends_on 'staticfloat/juliadeps/cairo' => :optional

  def install
    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make install"
  end
end
