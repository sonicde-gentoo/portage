# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

ECM_TEST="forceoptional"
KFMIN=6.26.0
QTMIN=6.10.1
inherit ecm plasma.sonic xdg

DESCRIPTION="Backend implementation for xdg-desktop-portal that is using Qt/KDE Frameworks"

LICENSE="LGPL-2+"
SLOT="6"
KEYWORDS="~amd64 ~arm64 ~ppc64 ~riscv ~x86"

# dev-qt/qtbase:= slot op: Uses Qt::GuiPrivate for qtx11extras_p.h
# dev-qt/qtbase:=[cups]: includes specifically the cups private header
# dev-qt/qtgui: QtXkbCommonSupport is provided by either IUSE libinput or X
COMMON_DEPEND="
	>=dev-qt/qtbase-${QTMIN}:6=[cups,dbus,gui,widgets]
	>=dev-qt/qtdeclarative-${QTMIN}:6
	|| (
		>=dev-qt/qtbase-${QTMIN}:6[libinput]
		>=dev-qt/qtbase-${QTMIN}:6[X]
	)
	>=sonicde-frameworks/sonic-frameworks-core-addons-${KFMIN}:6[dbus]
	>=sonicde-frameworks/sonic-frameworks-settings-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-crash-handler-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-keybind-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-gui-addons-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-internationalization-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-icon-themes-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-io-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-quick-ui-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-notifications-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-app-info-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-status-notification-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-widgets-addons-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-windowsystem-${KFMIN}:6
	x11-libs/libxkbcommon
"
DEPEND="${COMMON_DEPEND}
	>=dev-qt/qtbase-${QTMIN}:6[concurrent]
"
RDEPEND="${COMMON_DEPEND}
	sonicde-frameworks/sonic-frameworks-io-fuse:6
	sys-apps/xdg-desktop-portal
	sonicde-base/sonic-workspace
	sonicde-frameworks/sonic-frameworks-auth
	sonicde-frameworks/sonic-frameworks-autocomplete
	sonicde-frameworks/sonic-frameworks-data-views
	sonicde-frameworks/sonic-frameworks-device-integration
	sonicde-frameworks/sonic-frameworks-progress-ui
	sonicde-frameworks/sonic-frameworks-qml-bridge
	sonicde-frameworks/sonic-frameworks-settings-ui
	sonicde-frameworks/sonic-frameworks-text-codec
	sonicde-frameworks/sonic-frameworks-xml-gui
"
BDEPEND="
	>=dev-qt/qtbase-${QTMIN}:6
	virtual/pkgconfig
"

CMAKE_SKIP_TESTS=(
	# bugs: 926483, wants dbus/X11
	colorschemetest
)
