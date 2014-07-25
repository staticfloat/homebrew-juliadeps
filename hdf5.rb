require 'formula'

class Hdf5 < Formula
  homepage 'http://www.hdfgroup.org/HDF5'
  url 'http://www.hdfgroup.org/ftp/HDF5/releases/hdf5-1.8.13/src/hdf5-1.8.13.tar.bz2'
  sha1 '712955025f03db808f000d8f4976b8df0c0d37b5'

  bottle do
    root_url 'https://juliabottles.s3.amazonaws.com'
    cellar :any
    sha1 '9d5484e35913af5415c00ac01d641afdd86b6a25' => :lion
    sha1 'eaa5395ac74a962bd7e01762c435e7de12e5737e' => :mavericks
    sha1 'd37805e92f876579bc10d9a83633cf14878d0866' => :mountain_lion
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
