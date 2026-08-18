# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

ECM_HANDBOOK="forceoptional"
KFMIN=6.26.0
QTMIN=6.10.1
inherit ecm plasma.sonic xdg

DESCRIPTION="Wacom system settings module that supports different button/pen layout profiles"
HOMEPAGE="https://userbase.kde.org/Wacomtablet"

LICENSE="GPL-2"
SLOT="6"

# slot op: Uses Qt6::GuiPrivate for qtx11extras_p.h
RDEPEND="
	>=dev-libs/libwacom-0.30:=
	>=dev-qt/qtbase-${QTMIN}:6=[dbus,gui,widgets,X]
	>=dev-qt/qtdeclarative-${QTMIN}:6
	>=sonicde-frameworks/sonic-frameworks-settings-utils-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-settings-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-settings-ui-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-core-addons-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-dbus-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-keybind-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-internationalization-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-io-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-notifications-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-widgets-addons-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-windowsystem-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-xml-gui-${KFMIN}:6
	>=sonicde-base/sonic-interface-libraries-${KDE_CATV}:6=
	>=sonicde-base/sonic-plasma5-support-library-${KDE_CATV}:6
	>=x11-drivers/xf86-input-wacom-0.20.0
	x11-libs/libXi
	x11-libs/libxcb
"
DEPEND="${RDEPEND}
	x11-base/xorg-proto
	x11-libs/libX11
"
BDEPEND="sys-devel/gettext"

src_test() {
	# test needs DBus, bug 675548
	local myctestargs=(
		-E "(Test.KDED.DBusTabletService)"
	)

	ecm_src_test
}
