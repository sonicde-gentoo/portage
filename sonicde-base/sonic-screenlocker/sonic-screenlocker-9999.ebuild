# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

ECM_TEST="forceoptional"
KFMIN=6.26.0
QTMIN=6.10.1
inherit ecm plasma.sonic pam xdg

DESCRIPTION="Library and components for secure lock screen architecture"

LICENSE="GPL-2" # TODO: CHECK
SLOT="6"

# requires running environment w/ RDEPENDs (circular dep w/ plasma-workspace)
RESTRICT="test"

# qtbase slot op: GuiPrivate use in greeter
COMMON_DEPEND="
	>=dev-qt/qtbase-${QTMIN}:6=[dbus,gui,network,widgets]
	>=dev-qt/qtdeclarative-${QTMIN}:6
	>=sonicde-frameworks/sonic-frameworks-settings-utils-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-settings-${KFMIN}:6[qml]
	>=sonicde-frameworks/sonic-frameworks-settings-ui-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-core-addons-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-crash-handler-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-keybind-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-internationalization-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-idle-tracker-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-io-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-notifications-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-package-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-svg-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-windowsystem-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-xml-gui-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-device-integration-${KFMIN}:6
	>=sonicde-base/sonic-screen-library-${KDE_CATV}:6
	>=sonicde-base/sonic-interface-libraries-${KDE_CATV}:6=
	sys-libs/pam
	x11-libs/libX11
	x11-libs/libXi
	x11-libs/libxcb
	x11-libs/xcb-util-keysyms
"
DEPEND="${COMMON_DEPEND}
	x11-base/xorg-proto
"
RDEPEND="${COMMON_DEPEND}
	>=sonicde-frameworks/sonic-frameworks-qml-bridge-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-quick-ui-${KFMIN}:6
"
BDEPEND="
	>=sonicde-frameworks/sonic-frameworks-settings-utils-${KFMIN}:6
"
PDEPEND=">=sonicde-base/sonic-workspace-${KDE_CATV}:6"

src_install() {
	ecm_src_install

	newpamd "${FILESDIR}/kde-r1.pam" kde
	newpamd "${FILESDIR}/kde-fingerprint.pam" kde-fingerprint
	newpamd "${FILESDIR}/kde-smartcard.pam" kde-smartcard
}
