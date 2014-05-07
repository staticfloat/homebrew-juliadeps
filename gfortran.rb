require 'formula'

class Gfortran < Formula
  homepage 'http://gcc.gnu.org/wiki/GFortran'
  url 'http://ftpmirror.gnu.org/gcc/gcc-4.8.2/gcc-4.8.2.tar.bz2'
  mirror 'http://ftp.gnu.org/gnu/gcc/gcc-4.8.2/gcc-4.8.2.tar.bz2'
  sha1 '810fb70bd721e1d9f446b6503afe0a9088b62986'

  bottle do
    root_url 'http://archive.org/download/julialang/bottles'
    cellar :any
    revision 2
    sha1 '304c91ba355a7541a981092acee6d19790354c56' => :snow_leopard_or_later
  end

  def post_install
    # This is here to symlink the libs to alternate locations where they could be installed
    # we still need to do this, since otherwise mach_o_files doesn't find us, and we don't
    # get our install names fixed!
    mkdir_p prefix+'gfortran/lib'
    for f in ['quadmath.0', 'gcc_s.1', 'gfortran.3']
      quiet_system 'ln', '-fs', lib+"lib#{f}.dylib", prefix+"gfortran/lib/lib#{f}.dylib"
      quiet_system 'ln', '-fs', lib+"lib#{f}.dylib", prefix+"gfortran/lib/lib#{f[0..-3]}.dylib"
      quiet_system 'ln', '-fs', lib+"lib#{f}.dylib", lib+"lib#{f[0..-3]}.dylib"
    end
  end

  def install
    opoo "This formula is bottle-only!  If you actually want to install gfortran, use the gfortran formula provided by brew!"
  end
end
