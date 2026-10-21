# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="SonicDE Silver SDDM theme"
HOMEPAGE="https://github.com/Sonic-DE/sonic-silver-sddm"
if [[ ${PV} != *9999* ]]; then
	SRC_URI="https://github.com/Sonic-DE/sonic-silver-sddm/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}/sonic-silver-sddm-${PV}"
fi

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~loong ~ppc64 ~riscv ~x86"

RDEPEND="
	x11-misc/sddm[qt6(+)]
	sonicde-frameworks/sonic-frameworks-quick-ui:6
	sonicde-base/sonic-workspace:6
	sonicde-base/sonic-interface-libraries:6
	>=dev-qt/qtvirtualkeyboard-6.11.0:6
	>=dev-qt/qtbase-6.11.0:6[dbus,gui,widgets]
	>=dev-qt/qtdeclarative-6.11.0:6
"
BDEPEND="sonicde-frameworks/sonic-frameworks-cmake-modules:0"
