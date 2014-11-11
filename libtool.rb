require 'formula'

# Xcode 4.3 provides the Apple libtool.
# This is not the same so as a result we must install this as glibtool.

class Libtool < Formula
  homepage 'http://www.gnu.org/software/libtool/'
  url 'http://ftpmirror.gnu.org/libtool/libtool-2.4.2.tar.gz'
  mirror 'http://ftp.gnu.org/gnu/libtool/libtool-2.4.2.tar.gz'
  sha1 '22b71a8b5ce3ad86e1094e7285981cae10e6ff88'

  bottle do
    root_url 'https://juliabottles.s3.amazonaws.com'
    cellar :any
    revision 4
    sha1 '80a19de303ca7e8e813493913e9c5bdb28d0eff8' => :lion
    sha1 'b6888694df66ff77a205ca973b5eb6597a4628bf' => :mavericks
    sha1 'ae7bcea665a68f9636347337b04397d7696c34f9' => :mountain_lion
    sha1 "01d11a793cd4430863efa9f4454b7e665ad260a1" => :yosemite
  end

  if MacOS::Xcode.provides_autotools? or File.file? "/usr/bin/glibtoolize"
    keg_only "Xcode 4.2 and below provide glibtool."
  end

  option :universal

  # Allow -stdlib= to pass through to linker
  # http://git.savannah.gnu.org/gitweb/?p=libtool.git;a=commitdiff;h=8f975a1368594126e37d85511f1f96164e466d93
  # https://trac.macports.org/ticket/32982
  def patches; DATA; end

  def install
    ENV.universal_binary if build.universal?
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--program-prefix=g",
                          "--enable-ltdl-install"
    system "make install"
  end

  def caveats; <<-EOS.undent
    In order to prevent conflicts with Apple's own libtool we have prepended a "g"
    so, you have instead: glibtool and glibtoolize.
    EOS
  end

  test do
    system "#{bin}/glibtool", 'execute', '/usr/bin/true'
  end
end

__END__
diff --git a/libltdl/config/ltmain.sh b/libltdl/config/ltmain.sh
index 63ae69d..9ae038c 100644
--- a/libltdl/config/ltmain.sh
+++ b/libltdl/config/ltmain.sh
@@ -5851,9 +5851,10 @@ func_mode_link ()
       # -tp=*                Portland pgcc target processor selection
       # --sysroot=*          for sysroot support
       # -O*, -flto*, -fwhopr*, -fuse-linker-plugin GCC link-time optimization
+      # -stdlib=*            select c++ std lib with clang
       -64|-mips[0-9]|-r[0-9][0-9]*|-xarch=*|-xtarget=*|+DA*|+DD*|-q*|-m*| \
       -t[45]*|-txscale*|-p|-pg|--coverage|-fprofile-*|-F*|@*|-tp=*|--sysroot=*| \
-      -O*|-flto*|-fwhopr*|-fuse-linker-plugin)
+      -O*|-flto*|-fwhopr*|-fuse-linker-plugin|-stdlib=*)
         func_quote_for_eval "$arg"
 	arg="$func_quote_for_eval_result"
         func_append compile_command " $arg"
