# htop build for iOS
Builds and packages htop for iOS using Theos.

Instructions:

1. Have [Theos](https://git.io/theosinstall) and a toolchain (Xcode, or one listed on the Theos install page) set up.
2. Clone this repo and the submodule: `git clone --recursive https://github.com/kirb/ios-build-htop.git`
3. Fix the `include/IOKit` symlink to lead to the IOKit.framework headers from MacOSX.sdk, if its current path doesn’t exist for you.
3. `make do`

## License
This is free and unencumbered software released into the public domain. Refer to [LICENSE.md](LICENSE.md).

For htop license, refer to [htop COPYING](https://github.com/hishamhm/htop/blob/master/COPYING).

For licenses of headers, refer to the license comments in the headers.
