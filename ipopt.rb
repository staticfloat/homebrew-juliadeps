require 'formula'

class Ipopt < Formula
  homepage 'https://projects.coin-or.org/Ipopt'
  url 'http://www.coin-or.org/download/source/Ipopt/Ipopt-3.11.4.tgz'
  sha1 '909a7073e3e83989d1a8c5aceba2d1a96dc262d2'

  depends_on :fortran

  bottle do
    root_url 'http://s3.us.archive.org/julialang/bottles'
    cellar :any
    sha1 '2fdddf9c6753e12cac04ebc8531bf6847cc29bd4' => :mountain_lion
    sha1 '2fdddf9c6753e12cac04ebc8531bf6847cc29bd4' => :lion
    sha1 '2fdddf9c6753e12cac04ebc8531bf6847cc29bd4' => :snow_leopard
  end

  def patches
    # Patch to properly list shared library dependencies: 
    # https://projects.coin-or.org/BuildTools/ticket/105
    { :p1 => "https://raw.github.com/mlubin/Ipopt.jl/6c4131cea941c327e85a15135926dc0a17648646/deps/ipopt-shlibs.patch"
    }
  end

  def install
    system "cd ThirdParty/Mumps; ./get.Mumps"
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make"
    ENV.deparallelize  # make install fails in parallel.
    system "make install"

  end

  def post_install
    # pick up Julia's libgfortran!
    if (Tab.for_formula self).poured_from_bottle
      for file in [lib+'libcoinmumps.dylib', lib+'libipopt.dylib']
        file.ensure_writable do
          for lib in ["libgfortran.3.dylib", "libgcc_s.1.dylib", "libquadmath.0.dylib"]
            quiet_system "install_name_tool", "-change", '/usr/local/Cellar/gfortran/4.8.1/gfortran/lib/#{lib}', '@rpath/#{lib}', file
          end
        end
      end
    end
  end
end
