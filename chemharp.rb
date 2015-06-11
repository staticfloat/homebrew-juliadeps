class Chemharp < Formula
    desc "Chemharp, an efficient IO library for chemistry file formats"
    homepage "http://chemharp.readthedocs.org/"
    url "https://github.com/Luthaf/Chemharp/archive/0.2.1.tar.gz"
    sha256 "965223a94a5f0c0c22f4af1ad75b349fb2cc8e7868af74be4df71e17eaf981f2"

    head "https://github.com/Luthaf/Chemharp.git"

    depends_on "cmake" => :build
    depends_on "homebrew/science/netcdf" => :optional
    depends_on "boost"

    option "with-python", "Build python bindings"
    if build.with? "python-bindings"
        depends_on "boost-python"
    end

    option "with-fortran", "Build Fortran bindings"
    depends_on :fortran => :optional

    def install
        cmake_args = std_cmake_args
        if build.with? "python"
            cmake_args << "-DPYTHON_BINDING=ON"
        end
        if build.with? "fortran"
            cmake_args << "-DFORTRAN_BINDING=ON"
        end
        system "cmake", ".", *cmake_args
        system "make", "install"
    end
end
