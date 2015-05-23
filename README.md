homebrew-juliadeps
==================

Binary dependencies of third-party libraries on OSX for Julia.

Submitting a PR
===============

When requesting a new piece of software to be included, or a version bump, it is very helpful to follow a few guidelines.  Many pieces of software require a fair bit of investigation to ensure they are completely relocatable, so any effort to make the process smoother is appreciated.

* First, when opening a Pull Request, open it against the `staging` branch.  This is not "live", and allows the buildbots to attempt to build/test the software without affecting users.
* When submitting a new formula or bumping the version of an old one, remove all checksums from the `bottle` stanza and ensure the URLs for the software, any mirror URLs for the software, and the checksum are correct.  (For instance, if bumping `gettext` to the latest version, we would [update these URLs](https://github.com/staticfloat/homebrew-juliadeps/blob/d3dcfbb94b65cba01fdda96025aca02c009fa275/gettext.rb#L5-L6), ensure [this checksum](https://github.com/staticfloat/homebrew-juliadeps/blob/d3dcfbb94b65cba01fdda96025aca02c009fa275/gettext.rb#L7) was correct and remove [these lines](https://github.com/staticfloat/homebrew-juliadeps/blob/d3dcfbb94b65cba01fdda96025aca02c009fa275/gettext.rb#L12-L14). Removing the `bottle` checksum lines is important, as without doing so, `brew` will think there is a bottled version of the new software available.)
* When at all possible, search to see if the software of interest is available in Homebrew already.  Specifically, check to see if the software has been bottled and if there is a `cellar :any` line within the `bottle` stanza. 
* Don't be afraid to ping me (via `@staticfloat`) to get my attention, as GitHub does not send out emails when new issues/PRs are opened.  Otherwise, it may be a few days before I see your PR.
