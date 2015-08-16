class Chemharp < Formula
    desc "Chemharp, an efficient IO library for chemistry file formats"
    homepage "http://chemharp.readthedocs.org/"
    url "https://github.com/Luthaf/Chemharp/archive/0.3.0.tar.gz"
    sha256 "a4a4378be76170cd730d3bdfaab5c48e79e72c166fc690486d4127596979ce20"

    head "https://github.com/Luthaf/Chemharp.git"

    depends_on "cmake" => :build
    depends_on "homebrew/science/netcdf" => :optional
    depends_on "boost"

    bottle do
        root_url 'https://juliabottles.s3.amazonaws.com'
        cellar :any
        sha256 "e77bb7c95e961d80cc19f0f399542a3d4b740a8fce7bd12bb17c43ee0aba8794" => :mavericks
        sha256 "5958b4189e8749a30860f7d0f378ee6e24ae1f539fa46c47664924f54fe1d818" => :yosemite
    end

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
