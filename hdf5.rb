require 'formula'

class Hdf5 < Formula
  homepage 'http://www.hdfgroup.org/HDF5'
  url 'https://www.hdfgroup.org/ftp/HDF5/releases/hdf5-1.8.15-patch1/src/hdf5-1.8.15-patch1.tar.bz2'
  version '1.8.15p1'
  sha256 'a5afc630c4443547fff15e9637b5b10404adbed4c00206d89517d32d6668fb32'

  bottle do
    root_url 'https://juliabottles.s3.amazonaws.com'
    cellar :any
    sha256 "c7cfa56cddd7a6a80b9c9bd7c40ecb3ce9b513bb5b6c0d65c1818fafc26c5891" => :mavericks
    sha256 "8a86c1e64c45c55f949ebd77d964e53b5c409d04bf17c002d5d8b1709fc5898f" => :yosemite
    sha256 "e5cb6648fd9106df38e530c15687645f8d052fea89ef916334efa1f796fff5f4" => :el_capitan
  end

  # TODO - warn that these options conflict
  option :universal
  option 'enable-fortran', 'Compile Fortran bindings'
  option 'enable-cxx', 'Compile C++ bindings'
  option 'enable-threadsafe', 'Trade performance and C++ or Fortran support for thread safety'
  option 'enable-parallel', 'Compile parallel bindings'
  option 'enable-fortran2003', 'Compile Fortran 2003 bindings. Requires enable-fortran.'

  #depends_on :fortran if build.include? 'enable-fortran' or build.include? 'enable-fortran2003'
  depends_on 'staticfloat/juliadeps/szip'
  #depends_on :mpi => [:cc, :cxx, :f90] if build.include? "enable-parallel"

  def install
    ENV.universal_binary if build.universal?
    args = %W[
      --prefix=#{prefix}
      --enable-production
      --enable-debug=no
      --disable-dependency-tracking
      --with-zlib=/usr
      --with-szlib=#{HOMEBREW_PREFIX}
      --enable-filters=all
      --enable-static=yes
      --enable-shared=yes
    ]

    args << '--enable-parallel' if build.include? 'enable-parallel'
    if build.include? 'enable-threadsafe'
      args.concat %w[--with-pthread=/usr --enable-threadsafe]
    else
      if build.include? 'enable-cxx'
        args << '--enable-cxx'
      end
      if build.include? 'enable-fortran' or build.include? 'enable-fortran2003'
        args << '--enable-fortran'
        args << '--enable-fortran2003' if build.include? 'enable-fortran2003'
      end
    end

    if build.include? 'enable-parallel'
      ENV['CC'] = 'mpicc'
      ENV['FC'] = 'mpif90'
    end

    system "./configure", *args
    system "make install"
  end
end
