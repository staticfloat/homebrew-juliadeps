require 'formula'

## NOTE: this nettle formula has been specially patched to use the gmp provided
## by Julia.  This means that you won't be able to use it with non-julia executables!

class Nettle < Formula
  homepage 'http://www.lysator.liu.se/~nisse/nettle/'
  url 'http://www.lysator.liu.se/~nisse/archive/nettle-2.6.tar.gz'
  sha1 '401f982a0b365e04c8c38c4da42afdd7d2d51d80'

  #depends_on 'staticfloat/juliadeps/gmp'

  bottle do
    root_url 'http://juliabottles.s3-website-us-east-1.amazonaws.com/bottles'
    cellar :any
    sha1 'd2018089ade5d43ab362d7ebabba87fb916b7e6f' => :mountain_lion
    sha1 'd2018089ade5d43ab362d7ebabba87fb916b7e6f' => :lion
    sha1 'd2018089ade5d43ab362d7ebabba87fb916b7e6f' => :snow_leopard
  end

  def post_install
    # Rewrite nettle's dependency on libgmp to just be @rpath
    # that way we pick up Julia's libgmp dylib!
    binaries = Dir.glob("#{bin}/*").map{ |f| Pathname.new(f) }
    for file in [lib+'libhogweed.dylib', *binaries]
      file.ensure_writable do
        system "install_name_tool", "-change", '/usr/local/lib/libgmp.10.dylib', '@rpath/libgmp.10.dylib', file
        system "otool", "-L", file
      end
    end
  end

  def install
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--enable-shared"
    system "make"
    system "make install"
    system "make check"
  end
end
