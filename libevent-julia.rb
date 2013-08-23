require 'formula'
require 'libevent'

class LibeventJulia < Libevent
  bottle do
  cellar :any
  sha1 'edbc39163533b05adb1d5cd2206bae4e29503d2e' => :mountain_lion
end
