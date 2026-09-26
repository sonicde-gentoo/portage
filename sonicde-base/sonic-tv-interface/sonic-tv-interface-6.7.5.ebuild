# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

KFMIN=6.28.0
QTMIN=6.10.0
inherit ecm plasma.sonic

DESCRIPTION="SonicDE big-screen television interface"
LICENSE="CC-BY-SA-4.0 CC0-1.0 GPL-2 GPL-2+ GPL-3 LGPL-2+ LGPL-2.1 LGPL-3 MIT"
SLOT="6"
KEYWORDS="~amd64 ~arm64 ~loong ~ppc64 ~riscv ~x86"

DEPEND="
	>=dev-qt/qtbase-${QTMIN}:6[dbus,gui,network]
	>=dev-qt/qtdeclarative-${QTMIN}:6
	>=dev-qt/qtmultimedia-${QTMIN}:6
	>=dev-qt/qtwebengine-${QTMIN}:6
	>=dev-libs/qcoro-0.7.0:=[qml]
	media-libs/libsdl3
	>=sonicde-frameworks/sonic-frameworks-bluetooth-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-settings-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-internationalization-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-quick-ui-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-settings-utils-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-keybind-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-notifications-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-io-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-windowsystem-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-svg-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-dbus-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-icon-themes-${KFMIN}:6
	>=sonicde-base/sonic-screen-${KDE_CATV}:6
	>=sonicde-base/sonic-interface-libraries-${KDE_CATV}:6
	>=sonicde-base/sonic-activities-${KDE_CATV}:6
	>=sonicde-base/sonic-activities-stats-${KDE_CATV}:6
	>=sonicde-base/sonic-workspace-${KDE_CATV}:6
"
RDEPEND="${DEPEND}"
RDEPEND+=" !<kde-plasma/plasma-bigscreen-6.7.5 !kde-plasma/plasma-bigscreen:6/6"
PDEPEND+=" ~kde-plasma/plasma-bigscreen-6.7.5:6/6-sonicde"
