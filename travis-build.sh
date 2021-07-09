#!/bin/bash

set -x

apt -qq update
apt -qq -yy install equivs curl git wget gnupg2

### Install Dependencies

DEBIAN_FRONTEND=noninteractive apt -qq -yy install --no-install-recommends devscripts debhelper gettext lintian build-essential automake autotools-dev cmake extra-cmake-modules appstream

mk-build-deps -i -t "apt-get --yes" -r

### Clone repo.

git clone https://github.com/psifidotos/applet-window-buttons.git

mv applet-window-buttons/* .

rm -rf applet-window-buttons LICENSES README.md

### Build Deb

mkdir source
mv ./* source/ # Hack for debuild
cd source
debuild -b -uc -us
