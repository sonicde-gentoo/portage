# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit ecm sonic

DESCRIPTION="SonicDE component sonic-pyside-setup"
HOMEPAGE="https://github.com/Sonic-DE/sonic-pyside-setup"
if [[ ${PV} != *9999* ]]; then
	SRC_URI="https://github.com/Sonic-DE/sonic-pyside-setup/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}/sonic-pyside-setup-${PV}"
fi

LICENSE="GPL-2+"
SLOT="6"
IUSE="X"

RDEPEND="
	>=dev-qt/qtbase-6.8:6[dbus,gui,widgets,X]
	>=dev-qt/qtdeclarative-6.8:6

"
DEPEND="${RDEPEND}"

src_configure() {
	local mycmakeargs=( -DWITH_WAYLAND=OFF -DWITH_X11=ON )
	ecm_src_configure
}
