class Metis4 < Formula
  url "http://glaros.dtc.umn.edu/gkhome/fetch/sw/metis/OLD/metis-4.0.3.tar.gz"
  homepage "http://glaros.dtc.umn.edu/gkhome/views/metis"
  sha256 "5efa35de80703c1b2c4d0de080fafbcf4e0d363a21149a1ad2f96e0144841a55"

  bottle do
    cellar :any
  end

  keg_only "Conflicts with metis (5.x)."

  def install
    so = "dylib"
    ar = "libtool -dynamic -install_name #{lib}/$(notdir $@) -undefined dynamic_lookup -o"
    inreplace "Lib/Makefile", "libmetis.a", "libmetis.#{so}"
    make_args = ["COPTIONS=-fPIC", "AR=#{ar}", "RANLIB=echo", "METISLIB=../libmetis.#{so}"]
    system "make", *make_args
    bin.install %w[pmetis kmetis oemetis onmetis partnmesh partdmesh mesh2nodal mesh2dual graphchk]
    lib.install "libmetis.#{so}"
    include.install Dir["Lib/*.h"]
    (share / "metis4").install %w[Graphs/mtest Graphs/4elt.graph Graphs/metis.mesh Graphs/test.mgraph]
  end

  test do
    system "#{share}/metis4/mtest", "#{share}/metis4/4elt.graph"
    system "#{bin}/kmetis", "#{share}/metis4/4elt.graph", "40"
    system "#{bin}/onmetis", "#{share}/metis4/4elt.graph"
    system "#{bin}/pmetis", "#{share}/metis4/test.mgraph", "2"
    system "#{bin}/kmetis", "#{share}/metis4/test.mgraph", "2"
    system "#{bin}/kmetis", "#{share}/metis4/test.mgraph", "5"
    system "#{bin}/partnmesh", "#{share}/metis4/metis.mesh", "10"
    system "#{bin}/partdmesh", "#{share}/metis4/metis.mesh", "10"
    system "#{bin}/mesh2dual", "#{share}/metis4/metis.mesh"
  end
end
