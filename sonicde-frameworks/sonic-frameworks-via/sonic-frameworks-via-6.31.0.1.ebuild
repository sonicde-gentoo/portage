# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

QTMIN=6.11.0
inherit ecm sonic

DESCRIPTION="SonicDE component sonic-frameworks-via"
HOMEPAGE="https://github.com/Sonic-DE/sonic-frameworks-via"
if [[ ${PV} != *9999* ]]; then
	SRC_URI="https://github.com/Sonic-DE/sonic-frameworks-via/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}/sonic-frameworks-via-${PV}"
fi

LICENSE="GPL-2+"
SLOT="6/6.31"
KEYWORDS="~amd64 ~arm64 ~loong ~ppc64 ~riscv ~x86"

RDEPEND="
	>=dev-qt/qtbase-${QTMIN}:6[gui]
	dev-libs/hidapi
"
DEPEND="${RDEPEND}"
BDEPEND="virtual/pkgconfig"
