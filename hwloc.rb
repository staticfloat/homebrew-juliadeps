require 'formula'

class Hwloc < Formula
  homepage 'http://www.open-mpi.org/projects/hwloc/'
  url 'http://www.open-mpi.org/software/hwloc/v1.11/downloads/hwloc-1.11.1.tar.bz2'
  sha256 '48614061c4baa44dec7ec078459c3bd1f3ecaa39a39331a7eb857c945cca6c0f'

  bottle do
    root_url 'https://juliabottles.s3.amazonaws.com'
    cellar :any
  end

  depends_on 'staticfloat/juliadeps/pkg-config' => :build
  depends_on 'staticfloat/juliadeps/cairo' => :optional

  def install
    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make install"
  end
end
