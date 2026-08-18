# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

ECM_TEST="true"
KFMIN=6.26.0
QTMIN=6.10.1
inherit ecm plasma.sonic

DESCRIPTION="Daemon providing Global Keyboard Shortcut (Accelerator) functionality"

LICENSE="LGPL-2+"
SLOT="6"
IUSE="X"

REQUIRED_USE="test? ( X )"
RESTRICT="test" # requires installed instance

# slot op: Uses Qt6::GuiPrivate for qtx11extras_p.h
DEPEND="
	>=dev-qt/qtbase-${QTMIN}:6[dbus,gui,widgets,X?]
	>=sonicde-frameworks/sonic-frameworks-settings-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-core-addons-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-crash-handler-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-dbus-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-io-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-progress-ui-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-notifications-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-app-info-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-windowsystem-${KFMIN}:6[X?]
	X? (
		>=dev-qt/qtbase-${QTMIN}:6=[gui]
		x11-libs/libxcb
		x11-libs/xcb-util-keysyms
	)
"
RDEPEND="${DEPEND}
	!<sonicde-frameworks/sonic-frameworks-keybind-5.116.0-r2:5[-kf6compat(-)]
"
BDEPEND=">=dev-qt/qttools-${QTMIN}:6[linguist]"

src_configure() {
	local mycmakeargs=(
		-DWITH_X11=$(usex X)
	)
	ecm_src_configure
}

# src_test() {
# 	XDG_CURRENT_DESKTOP="KDE" ecm_src_test # bug 789342
# }
