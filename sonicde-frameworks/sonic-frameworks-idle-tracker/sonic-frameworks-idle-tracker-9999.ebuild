# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

ECM_TEST="false"
QTMIN=6.10.1
inherit ecm frameworks.sonic

DESCRIPTION="Framework for detection and notification of device idle time"
LICENSE="LGPL-2+"
IUSE="xscreensaver"

RDEPEND="
	>=dev-qt/qtbase-${QTMIN}:6[gui]
	x11-libs/libX11
	x11-libs/libxcb
	x11-libs/libXext
	xscreensaver? (
		>=dev-qt/qtbase-${QTMIN}:6[dbus]
		x11-libs/libXScrnSaver
	)
"
DEPEND="${RDEPEND}
"

src_prepare() {
	ecm_src_prepare
	if ! use xscreensaver; then
		sed -i -e "s/\${X11_Xscreensaver_FOUND}/0/" CMakeLists.txt || die
	fi
}
