require 'formula'

class Hwloc < Formula
  homepage 'http://www.open-mpi.org/projects/hwloc/'
  url 'http://www.open-mpi.org/software/hwloc/v1.11/downloads/hwloc-1.11.1.tar.bz2'
  sha256 '48614061c4baa44dec7ec078459c3bd1f3ecaa39a39331a7eb857c945cca6c0f'

  bottle do
    root_url 'https://juliabottles.s3.amazonaws.com'
    cellar :any
    sha256 "54c6c707dee5769903d9238da24167e8be3debaceb0f1f075d3774f7e7fc0f8d" => :mavericks
    sha256 "28d769052327a2dd9f68b950825e2c66b47fc5c02b6e7e940be867091e499f72" => :yosemite
    sha256 "3357af9fe518f301e2feca9ee5214904ec49152808ab8854d21701cf3a91f044" => :el_capitan
  end

  depends_on 'staticfloat/juliadeps/pkg-config' => :build
  depends_on 'staticfloat/juliadeps/cairo' => :optional

  def install
    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make install"
  end
end
