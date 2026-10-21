# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

KFMIN=6.30.0
QTMIN=6.11.0
KDE_CATV=$(ver_cut 1-3)
inherit ecm sonic

DESCRIPTION="SonicDE component sonic-mobile-interface"
HOMEPAGE="https://github.com/Sonic-DE/sonic-mobile-interface"
if [[ ${PV} != *9999* ]]; then
	SRC_URI="https://github.com/Sonic-DE/sonic-mobile-interface/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}/sonic-mobile-interface-${PV}"
fi

LICENSE="GPL-2+"
SLOT="6"
KEYWORDS="~amd64 ~arm64 ~loong ~ppc64 ~riscv ~x86"

RDEPEND="
	>=sonicde-base/sonic-workspace-${KDE_CATV}:6
	>=sonicde-base/sonic-screen-library-${KDE_CATV}:6
	>=sonicde-base/sonic-activities-${KDE_CATV}:6
	>=sonicde-base/sonic-interface-libraries-${KDE_CATV}:6=
	x11-libs/libxcb
	virtual/libudev:=
	media-libs/libepoxy
	>=dev-qt/qtsensors-${QTMIN}:6
	dev-libs/qcoro[dbus,qml]
	>=sonicde-frameworks/sonic-frameworks-windowsystem-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-settings-utils-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-settings-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-progress-ui-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-package-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-notifications-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-keybind-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-io-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-internationalization-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-device-integration-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-dbus-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-data-models-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-core-addons-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-app-info-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-auth-${KFMIN}:6
	>=dev-qt/qtbase-${QTMIN}:6[dbus,gui,widgets]
	>=dev-qt/qtdeclarative-${QTMIN}:6=
	>=sonicde-base/sonic-pipewire-${KDE_CATV}:6
	>=sonicde-base/sonic-win-${KDE_CATV}:6=
	>=sonicde-frameworks/sonic-frameworks-cmake-modules-${KFMIN}:0
	>=sonicde-frameworks/sonic-frameworks-modemmanager-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-networkmanager-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-quick-ui-addons-0.6:6
"
DEPEND="${RDEPEND}"
RDEPEND+=" !<kde-plasma/plasma-mobile-6.8.0 !kde-plasma/plasma-mobile:6/6"
PDEPEND+=" ~kde-plasma/plasma-mobile-6.8.0:6/6-sonicde"
