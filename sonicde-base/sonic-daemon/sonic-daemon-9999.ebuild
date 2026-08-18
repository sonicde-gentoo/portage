# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

ECM_QTHELP="false"
ECM_TEST="false"
QTMIN=6.10.1
inherit ecm frameworks.sonic

DESCRIPTION="Central daemon of KDE workspaces"

LICENSE="LGPL-2+"
IUSE="+man"

DEPEND="
	>=dev-qt/qtbase-${QTMIN}:6[dbus,gui,widgets]
	=sonicde-frameworks/sonic-frameworks-settings-${KDE_CATV}*:6[dbus]
	=sonicde-frameworks/sonic-frameworks-core-addons-${KDE_CATV}*:6
	=sonicde-frameworks/sonic-frameworks-crash-handler-${KDE_CATV}*:6
	=sonicde-frameworks/sonic-frameworks-dbus-${KDE_CATV}*:6
	=sonicde-frameworks/sonic-frameworks-app-info-${KDE_CATV}*:6
"
RDEPEND="${DEPEND}
	sonicde-frameworks/sonic-frameworks-cmake-modules
"
BDEPEND="man? ( >=sonicde-frameworks/sonic-frameworks-doctools-${KDE_CATV}:6 )"

src_configure() {
	local mycmakeargs=(
		$(cmake_use_find_package man KF6DocTools)
	)

	ecm_src_configure
}
