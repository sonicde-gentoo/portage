# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake sonic

DESCRIPTION="SonicDE Qt bindings for libaccounts-glib"
HOMEPAGE="https://github.com/Sonic-DE/sonic-qt-accounts-library"
if [[ ${PV} != *9999* ]]; then
	SRC_URI="https://github.com/Sonic-DE/sonic-qt-accounts-library/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}/sonic-qt-accounts-library-${PV}"
fi

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~loong ~ppc64 ~riscv ~x86"

RDEPEND="
	dev-libs/glib:2
	>=dev-qt/qtbase-6.8:6[xml]
	>=net-libs/libaccounts-glib-1.23:=
"
DEPEND="${RDEPEND}"
BDEPEND="virtual/pkgconfig"
RDEPEND+=" !<net-libs/accounts-qt-1.17.2 !net-libs/accounts-qt:0/0"
PDEPEND+=" ~net-libs/accounts-qt-1.17.2:0/0-sonicde"
