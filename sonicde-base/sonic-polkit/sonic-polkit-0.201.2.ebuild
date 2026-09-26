# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake sonic

DESCRIPTION="SonicDE Qt wrapper around polkit-1"
HOMEPAGE="https://github.com/Sonic-DE/sonic-polkit"
if [[ ${PV} != *9999* ]]; then
	SRC_URI="https://github.com/Sonic-DE/sonic-polkit/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}/sonic-polkit-${PV}"
fi

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~loong ~ppc64 ~riscv ~x86"

RDEPEND="
	dev-libs/glib:2
	>=dev-qt/qtbase-6.8:6[dbus,gui,widgets]
	>=sys-auth/polkit-0.103
"
DEPEND="${RDEPEND}"
BDEPEND="virtual/pkgconfig"
RDEPEND+=" !<sys-auth/polkit-qt-0.201.2 !sys-auth/polkit-qt:0/0"
PDEPEND+=" ~sys-auth/polkit-qt-0.201.2:0/0-sonicde"
