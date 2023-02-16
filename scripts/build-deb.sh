#! /bin/bash

set -x

### Update sources

wget -qO /etc/apt/sources.list.d/neon-user-repo.list https://raw.githubusercontent.com/Nitrux/iso-tool/development/configs/files/sources.list.neon.user


### Download Source

git clone --depth 1 --branch $APPLETWINDOWBUTTONS_BRANCH https://github.com/psifidotos/applet-window-buttons.git

mv applet-window-buttons/* .

rm -rf applet-window-buttons LICENSES README.md

### Compile Source

mkdir -p build && cd build

cmake \
	-DCMAKE_INSTALL_PREFIX=/usr \
	-DENABLE_BSYMBOLICFUNCTIONS=OFF \
	-DQUICK_COMPILER=ON \
	-DCMAKE_BUILD_TYPE=Release \
	-DCMAKE_INSTALL_SYSCONFDIR=/etc \
	-DCMAKE_INSTALL_LOCALSTATEDIR=/var \
	-DCMAKE_EXPORT_NO_PACKAGE_REGISTRY=ON \
	-DCMAKE_FIND_PACKAGE_NO_PACKAGE_REGISTRY=ON \
	-DCMAKE_INSTALL_RUNSTATEDIR=/run "-GUnix Makefiles" \
	-DCMAKE_VERBOSE_MAKEFILE=ON \
	-DCMAKE_INSTALL_LIBDIR=lib/x86_64-linux-gnu ../applet-window-buttons/

make -j$(nproc)

### Run checkinstall and Build Debian Package

>> description-pak printf "%s\n" \
	'Applet to display window buttons in Plasma.' \
	'' \
	'This plasmoid adds window controls to a Plasma panel or a Latte Dock panel' \
	''

checkinstall -D -y \
	--install=no \
	--fstrans=yes \
	--pkgname=applet-window-buttons \
	--pkgversion=$PACKAGE_VERSION \
	--pkgarch=amd64 \
	--pkgrelease="1" \
	--pkglicense=LGPL-3 \
	--pkggroup=lib \
	--pkgsource=applet-window-buttons \
	--pakdir=. \
	--maintainer=uri_herrera@nxos.org \
	--provides=applet-window-buttons \
	--requires=libc6,libkf5configcore5,libkf5coreaddons5,libkf5i18n5,libkf5notifications5,libqt5core5a,libqt5gui5,libqt5qml5,libstdc++6,libsm6,qml-module-org-kde-kirigami2,qml-module-qtquick-controls2,qml-module-qtquick-shapes \
	--nodoc \
	--strip=no \
	--stripso=yes \
	--reset-uids=yes \
	--deldesc=yes
