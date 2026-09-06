# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

KFMIN=6.26.0
QTMIN=6.10.1
inherit ecm plasma.sonic xdg

DESCRIPTION="Oxygen visual style for the Plasma desktop"

LICENSE="GPL-2" # TODO: CHECK
SLOT="6"
IUSE="X"

# slot op: Uses Qt6::GuiPrivate for qtx11extras_p.h
COMMON_DEPEND="
	>=dev-qt/qtbase-${QTMIN}:6[dbus,gui,widgets]
	>=dev-qt/qtdeclarative-${QTMIN}:6
	>=sonicde-frameworks/sonic-frameworks-qt-integration-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-settings-utils-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-autocomplete-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-settings-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-settings-ui-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-core-addons-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-gui-addons-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-internationalization-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-widgets-addons-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-windowsystem-${KFMIN}:6
	>=sonicde-base/sonic-decoration-${KDE_CATV}:6
	>=sonicde-base/sonic-interface-libraries-${KDE_CATV}:6=
	X? (
		>=dev-qt/qtbase-${QTMIN}:6=[gui,X]
		x11-libs/libxcb
	)
"
DEPEND="${COMMON_DEPEND}
	>=sonicde-frameworks/sonic-frameworks-app-info-${KFMIN}:6
"
RDEPEND="${COMMON_DEPEND}
	!<sonicde-base/sonic-interface-libraries-6.1.90:*[-kf6compat(-)]
	!<${CATEGORY}/${PN}-6.5.0:5
	>=dev-qt/qtsvg-${QTMIN}:6
"

src_configure() {
	local mycmakeargs=(
		-DBUILD_QT6=ON
		-DBUILD_QT5=OFF
		$(cmake_use_find_package X XCB)
	)
	ecm_src_configure
}
