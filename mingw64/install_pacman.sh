#!/usr/bin/env bash

set -euox pipefail


[[ -d '/tmp/git-sdk-64' ]] \
  || git clone --depth=1 https://github.com/git-for-windows/git-sdk-64.git /tmp/git-sdk-64
[[ -d '/tmp/build-extra' ]] \
  || git clone --depth=1 https://github.com/git-for-windows/build-extra.git /tmp/build-extra
[[ -d '/var/lib' ]] \
  || mkdir -p /var/lib
[[ -d '/usr/share/makepkg' ]] \
  || mkdir -p /usr/share/makepkg

cp -a /tmp/git-sdk-64/usr/bin/pacman* /usr/bin/
cp -a /tmp/git-sdk-64/etc/pacman.* /etc/
cp -a /tmp/git-sdk-64/var/lib/pacman /var/lib/
cp -a /tmp/git-sdk-64/usr/share/makepkg/util* /usr/share/makepkg/

pacman --database --check

pacman-key --add /tmp/build-extra/git-for-windows-keyring/git-for-windows.gpg
pacman-key --lsign-key 1A9F3986

# pacman -Syyu
# pacman -Syy curl gcc git make rsync tree wget zsh
# pacman -Syy base-devel gettext-devel isl libcrypt-devel mpc msys2-devel ncurses-devel
# pacman -Scc
