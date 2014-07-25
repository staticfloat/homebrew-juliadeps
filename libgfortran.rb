require 'formula'

class Libgfortran < Formula
  homepage 'http://gcc.gnu.org/wiki/GFortran'

  def post_install
    # This is here to symlink the libs to alternate locations where they could be installed
    # we still need to do this, since otherwise mach_o_files doesn't find us, and we don't
    # get our install names fixed!
    if (Tab.for_formula self).poured_from_bottle
      mkdir_p prefix+'gfortran/lib'
      for f in ['quadmath.0', 'gcc_s.1', 'gfortran.3']
        quiet_system 'ln', '-fs', lib+"lib#{f}.dylib", prefix+"gfortran/lib/lib#{f}.dylib"
        quiet_system 'ln', '-fs', lib+"lib#{f}.dylib", prefix+"gfortran/lib/lib#{f[0..-3]}.dylib"
        quiet_system 'ln', '-fs', lib+"lib#{f}.dylib", lib+"lib#{f[0..-3]}.dylib"
      end
    end
  end

  def install
    # To generate a libgfortran installation, steal libraries from gcc!
    for f in ['quadmath.0', 'gcc_s.1', 'gfortran.3']
      quiet_system 'cp', "#{Formula['gcc'].prefix}/gfortran/lib/lib#{f}.dylib", lib
    end
  end
end
