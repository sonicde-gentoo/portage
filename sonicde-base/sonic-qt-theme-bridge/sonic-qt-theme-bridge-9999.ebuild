# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

KFMIN=6.26.0
QTMIN=6.10.1
inherit ecm plasma.sonic xdg

DESCRIPTION="Qt Platform Theme integration plugins for the Plasma workspaces"

LICENSE="LGPL-2+"
SLOT="6"

# requires running kde environment
RESTRICT="test"

# slot ops: qdbus*_p.h and Qt6::GuiPrivate for qtx11extras_p.h
COMMON_DEPEND="
	>=dev-qt/qtbase-${QTMIN}:6=[dbus,gui,widgets]
	>=dev-qt/qtdeclarative-${QTMIN}:6
	>=sonicde-frameworks/sonic-frameworks-color-scheme-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-autocomplete-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-settings-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-core-addons-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-gui-addons-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-internationalization-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-icon-themes-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-io-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-progress-ui-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-notifications-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-status-notification-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-windowsystem-${KFMIN}:6
	x11-libs/libXcursor
	x11-libs/libxcb
"
DEPEND="${COMMON_DEPEND}
"
RDEPEND="${COMMON_DEPEND}
	!<${CATEGORY}/${PN}-6.5.0:5
	>=sonicde-frameworks/sonic-frameworks-quick-desktop-style-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-quick-silver-style-${KDE_CATV}:6
	media-fonts/hack
	media-fonts/noto
	media-fonts/noto-emoji
	sonicde-base/sonic-silver
	sonicde-frameworks/sonic-frameworks-settings-ui
	sonicde-frameworks/sonic-frameworks-widgets-addons
"
PDEPEND=">=sonicde-base/xdg-desktop-portal-sonicde-${KDE_CATV}:6"
BDEPEND=">=dev-qt/qtbase-${QTMIN}:6"

src_configure() {
	local mycmakeargs=(
		-DBUILD_QT6=ON
		-DBUILD_QT5=OFF
		-DDEFAULT_UNION_STYLE=OFF
	)
	ecm_src_configure
}
