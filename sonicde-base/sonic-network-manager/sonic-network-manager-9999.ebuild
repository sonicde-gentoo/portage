# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

ECM_TEST="true"
KFMIN=6.26.0
QTMIN=6.10.1
inherit ecm plasma.sonic xdg

DESCRIPTION="KDE Plasma applet for NetworkManager"

LICENSE="GPL-2 LGPL-2.1"
SLOT="6"
IUSE="openconnect teamd"

COMMON_DEPEND="
	dev-libs/openssl:=
	dev-libs/qcoro[dbus]
	>=dev-libs/qtkeychain-0.16.0:=
	>=dev-qt/qtbase-${QTMIN}:6[dbus,gui,network,widgets,xml]
	>=dev-qt/qtdeclarative-${QTMIN}:6[widgets]
	>=sonicde-frameworks/sonic-frameworks-settings-utils-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-color-scheme-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-autocomplete-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-settings-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-core-addons-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-dbus-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-internationalization-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-io-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-data-views-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-progress-ui-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-notifications-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-app-info-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-svg-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-widgets-addons-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-windowsystem-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-xml-gui-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-modemmanager-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-networkmanager-${KFMIN}:6[teamd=]
	>=sonicde-frameworks/sonic-frameworks-device-integration-${KFMIN}:6
	>=sonicde-base/sonic-interface-libraries-${KDE_CATV}:6=
	net-misc/mobile-broadband-provider-info
	net-misc/networkmanager[teamd=]
	openconnect? (
		>=dev-qt/qtwebengine-${QTMIN}:6
		net-vpn/networkmanager-openconnect
		net-vpn/openconnect:=
	)
"
RDEPEND="${COMMON_DEPEND}
	>=sonicde-frameworks/sonic-frameworks-qml-bridge-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-quick-ui-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-quick-charts-${KFMIN}:6
"
DEPEND="${COMMON_DEPEND}
	>=net-misc/modemmanager-1.20
"
BDEPEND="
	>=sonicde-frameworks/sonic-frameworks-settings-utils-${KFMIN}:6
	virtual/pkgconfig
"

CMAKE_SKIP_TESTS=(
	# https://bugs.kde.org/show_bug.cgi?id=506217
	mobileproviderstest
)

src_configure() {
	local mycmakeargs=(
		-DBUILD_OPENCONNECT=$(usex openconnect)
	)

	ecm_src_configure
}

pkg_postinst() {
	xdg_pkg_postinst

	if ! has_version "sonicde-frameworks/sonic-frameworks-settings-utils:6"; then
		elog "${PN} is not terribly useful without sonicde-frameworks/sonic-frameworks-settings-utils:6."
		elog "However, the networkmanagement KCM can be called from either systemsettings"
		elog "or manually: $ kcmshell6 kcm_networkmanagement"
	fi
}
