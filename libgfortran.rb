require 'formula'

class Libgfortran < Formula
  homepage 'http://gcc.gnu.org/wiki/GFortran'
  url 'https://github.com/staticfloat/homebrew-libgfortran-formula/archive/master.tar.gz'
  sha1 '09328c065c42051fab341e660837704a3b1f5d4a'
  version '4.9.1'

  bottle do
    root_url 'https://juliabottles.s3.amazonaws.com'
    cellar :any
    sha1 '0e91476d934cf816f7e9f4b2035167bc92631c7f' => :lion
    sha1 '3d74269dba281abbc1209beeabd9169054c8e6f8' => :mavericks
    sha1 '03d5dce3825381bc4f4c8e6543f1753c96f4a653' => :mountain_lion
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
    # To generate a libgfortran installation, steal libraries from gcc!
    if not Formula['gcc'].installed?
      odie "Must install gcc formula first!"
    end
    for f in ['quadmath.0', 'gcc_s.1', 'gfortran.3']
      quiet_system 'cp', "#{Formula['gcc'].prefix}/gfortran/lib/lib#{f}.dylib", lib
    end
  end
end