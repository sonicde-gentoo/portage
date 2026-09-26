# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit ecm sonic

DESCRIPTION="SonicDE component sonic-polkit-agent"
HOMEPAGE="https://github.com/Sonic-DE/sonic-polkit-agent"
if [[ ${PV} != *9999* ]]; then
	SRC_URI="https://github.com/Sonic-DE/sonic-polkit-agent/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}/sonic-polkit-agent-${PV}"
fi

LICENSE="GPL-2+"
SLOT="6"
KEYWORDS="~amd64 ~arm64 ~loong ~ppc64 ~riscv ~x86"

RDEPEND="
	>=dev-qt/qtbase-6.8:6[dbus,gui,widgets]
	>=dev-qt/qtdeclarative-6.8:6
	sonicde-base/sonic-polkit
	sonicde-frameworks/sonic-frameworks-cmake-modules
	sonicde-frameworks/sonic-frameworks-core-addons
	sonicde-frameworks/sonic-frameworks-crash-handler
	sonicde-frameworks/sonic-frameworks-dbus
	sonicde-frameworks/sonic-frameworks-internationalization
	sonicde-frameworks/sonic-frameworks-notifications
	sonicde-frameworks/sonic-frameworks-windowsystem
"
DEPEND="${RDEPEND}"
RDEPEND+=" !<kde-plasma/polkit-kde-agent-6.7.3 !kde-plasma/polkit-kde-agent:6/6"
PDEPEND+=" ~kde-plasma/polkit-kde-agent-6.7.3:6/6-sonicde"
