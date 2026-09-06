# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit ecm sonic

DESCRIPTION="SonicDE component silver-sddm"
HOMEPAGE="https://github.com/Sonic-DE/silver-sddm"
if [[ ${PV} != *9999* ]]; then
	SRC_URI="https://github.com/Sonic-DE/silver-sddm/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}/silver-sddm-${PV}"
fi

LICENSE="GPL-2+"
SLOT="0"
IUSE="X"

RDEPEND="
	>=dev-qt/qtbase-6.8:6[dbus,gui,widgets,X]
	>=dev-qt/qtdeclarative-6.8:6
	sonicde-frameworks/sonic-frameworks-cmake-modules
"
DEPEND="${RDEPEND}"

src_configure() {
	local mycmakeargs=( -DWITH_WAYLAND=OFF -DWITH_X11=ON )
	ecm_src_configure
}
