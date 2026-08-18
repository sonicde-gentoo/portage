# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

ECM_QTHELP="true"
ECM_TEST="true"
KFMIN=6.26.0
QTMIN=6.10.1
inherit ecm plasma.sonic

DESCRIPTION="Support components for porting from KF5/Qt5 to KF6/Qt6"

LICENSE="GPL-2+ LGPL-2+"
SLOT="6"
IUSE="activities geolocation ksysguard X"

RESTRICT="test" # bug 926347

DEPEND="
	>=dev-qt/qtbase-${QTMIN}:6[dbus,gui,sql,widgets]
	>=dev-qt/qtdeclarative-${QTMIN}:6
	>=sonicde-frameworks/sonic-frameworks-settings-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-core-addons-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-gui-addons-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-holidays-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-internationalization-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-idle-tracker-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-io-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-notifications-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-app-info-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-unit-conversion-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-device-integration-${KFMIN}:6
	activities? ( >=sonicde-base/sonic-activities-${KDE_CATV}:6= )
	geolocation? ( >=sonicde-frameworks/sonic-frameworks-networkmanager-${KFMIN}:6 )
	ksysguard? ( >=sonicde-base/sonic-system-monitor-library-${KDE_CATV}:6 )
	X? ( x11-libs/libX11 )
"
RDEPEND="${DEPEND}
	!sonicde-base/sonic-workspace:5
	!<sonicde-base/sonic-workspace-6.5.90:6
"

src_configure() {
	local mycmakeargs=(
		$(cmake_use_find_package activities PlasmaActivities)
		$(cmake_use_find_package geolocation KF6NetworkManagerQt)
		$(cmake_use_find_package ksysguard KSysGuard)
		-DWITH_X11=$(usex X)
	)
	ecm_src_configure
}
