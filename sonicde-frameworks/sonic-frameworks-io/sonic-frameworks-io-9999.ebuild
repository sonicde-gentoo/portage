# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

ECM_DESIGNERPLUGIN="true"
ECM_HANDBOOK="optional"
ECM_HANDBOOK_DIR="docs"
ECM_TEST="forceoptional"
QTMIN=6.10.1
inherit ecm flag-o-matic frameworks.sonic xdg

DESCRIPTION="Framework providing transparent file and data management"

LICENSE="LGPL-2+"
IUSE="acl +kwallet X"

# tests hang
RESTRICT="test"

# slot op: Uses Qt6::GuiPrivate for qtx11extras_p.h
COMMON_DEPEND="
	>=dev-qt/qtbase-${QTMIN}:6[dbus,gui,network,ssl,widgets,X?]
	>=dev-qt/qtdeclarative-${QTMIN}:6
	=sonicde-frameworks/sonic-frameworks-bookmarks-${KDE_CATV}*:6
	=sonicde-frameworks/sonic-frameworks-text-codec-${KDE_CATV}*:6
	=sonicde-frameworks/sonic-frameworks-color-scheme-${KDE_CATV}*:6
	=sonicde-frameworks/sonic-frameworks-autocomplete-${KDE_CATV}*:6
	=sonicde-frameworks/sonic-frameworks-settings-${KDE_CATV}*:6
	=sonicde-frameworks/sonic-frameworks-core-addons-${KDE_CATV}*:6
	=sonicde-frameworks/sonic-frameworks-crash-handler-${KDE_CATV}*:6
	=sonicde-frameworks/sonic-frameworks-dbus-${KDE_CATV}*:6
	=sonicde-frameworks/sonic-frameworks-gui-addons-${KDE_CATV}*:6
	=sonicde-frameworks/sonic-frameworks-internationalization-${KDE_CATV}*:6
	=sonicde-frameworks/sonic-frameworks-icon-themes-${KDE_CATV}*:6
	=sonicde-frameworks/sonic-frameworks-data-views-${KDE_CATV}*:6
	=sonicde-frameworks/sonic-frameworks-progress-ui-${KDE_CATV}*:6
	=sonicde-frameworks/sonic-frameworks-notifications-${KDE_CATV}*:6
	=sonicde-frameworks/sonic-frameworks-app-info-${KDE_CATV}*:6
	=sonicde-frameworks/sonic-frameworks-text-widgets-${KDE_CATV}*:6
	=sonicde-frameworks/sonic-frameworks-widgets-addons-${KDE_CATV}*:6
	=sonicde-frameworks/sonic-frameworks-windowsystem-${KDE_CATV}*:6[?,X?]
	=sonicde-frameworks/sonic-frameworks-device-integration-${KDE_CATV}*:6
	sys-apps/util-linux
	acl? (
		sys-apps/attr
		virtual/acl
	)
	handbook? (
		dev-libs/libxml2:=
		dev-libs/libxslt
		=sonicde-frameworks/sonic-frameworks-archive-${KDE_CATV}*:6
		=sonicde-frameworks/sonic-frameworks-doctools-${KDE_CATV}*:6
	)
	kwallet? ( =sonicde-frameworks/sonic-frameworks-keyring-${KDE_CATV}*:6 )
	X? ( >=dev-qt/qtbase-${QTMIN}:6=[gui] )
"
DEPEND="${COMMON_DEPEND}
	>=dev-qt/qtbase-${QTMIN}:6[concurrent]
"
RDEPEND="${COMMON_DEPEND}
	>=dev-qt/qtbase-${QTMIN}:6[libproxy]
	sys-power/switcheroo-control
"
# bug 944812: File Properties is accessible from KFileWidget (KIO); this
# provides access to keditfiletype binary via KWidgetsAddons (Tier1)
# Typical KIO revdeps (dolphin, krusader et al.) can rely on this dep
PDEPEND="
	>=sonicde-base/sonic-daemon-${KDE_CATV}:6
	sonicde-base/sonic-desktop-interface
"

src_configure() {
	use elibc_musl && append-ldflags -Wl,-z,stack-size=0x100000 # upstream bug 470763

	local mycmakeargs=(
		$(cmake_use_find_package acl ACL)
		$(cmake_use_find_package kwallet KF6Wallet)
		-DWITH_WAYLAND=OFF
		-DWITH_X11=$(usex X)
	)

	ecm_src_configure
}
