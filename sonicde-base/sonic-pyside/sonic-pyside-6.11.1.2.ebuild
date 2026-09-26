# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit ecm sonic

DESCRIPTION="SonicDE Python bindings setup"
HOMEPAGE="https://github.com/Sonic-DE/sonic-pyside"
if [[ ${PV} != *9999* ]]; then
	SRC_URI="https://github.com/Sonic-DE/sonic-pyside/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}/sonic-pyside-${PV}"
fi

LICENSE="GPL-2+"
SLOT="6"
KEYWORDS="~amd64 ~arm64 ~loong ~ppc64 ~riscv ~x86"

RDEPEND="
	>=dev-qt/qtbase-6.8:6[dbus,gui,widgets]
	>=dev-qt/qtdeclarative-6.8:6

"
DEPEND="${RDEPEND}"
