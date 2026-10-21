# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

KFMIN=6.30.0
QTMIN=6.11.0
KDE_CATV=$(ver_cut 1-3)
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
	>=sonicde-frameworks/sonic-frameworks-quick-ui-${KFMIN}:6
	>=dev-qt/qtbase-${QTMIN}:6[dbus,gui,widgets]
	>=dev-qt/qtdeclarative-${QTMIN}:6
	sonicde-base/sonic-polkit
	>=sonicde-frameworks/sonic-frameworks-cmake-modules-${KFMIN}:0
	>=sonicde-frameworks/sonic-frameworks-core-addons-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-crash-handler-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-dbus-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-internationalization-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-notifications-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-windowsystem-${KFMIN}:6
"
DEPEND="${RDEPEND}"
RDEPEND+=" !<kde-plasma/polkit-kde-agent-6.8.0 !kde-plasma/polkit-kde-agent:6/6"
PDEPEND+=" ~kde-plasma/polkit-kde-agent-6.8.0:6/6-sonicde"
