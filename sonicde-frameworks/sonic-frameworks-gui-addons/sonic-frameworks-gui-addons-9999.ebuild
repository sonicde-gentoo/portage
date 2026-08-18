# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

ECM_PYTHON_BINDINGS="off"
QTMIN=6.10.1
inherit ecm frameworks.sonic xdg

DESCRIPTION="Framework providing assorted high-level user interface components"

LICENSE="LGPL-2+"
IUSE="dbus X"

# slot op: includes qpa/qplatformnativeinterface.h, private/qguiapplication_p.h
COMMON_DEPEND="
	>=dev-qt/qtbase-${QTMIN}:6[gui]
	>=dev-qt/qtdeclarative-${QTMIN}:6
	dbus? ( >=dev-qt/qtbase-${QTMIN}:6=[dbus] )
	X? (
		>=dev-qt/qtbase-${QTMIN}:6[X]
		x11-libs/libX11
	)
"
DEPEND="${COMMON_DEPEND}
	X? (
		x11-base/xorg-proto
		x11-libs/libxcb
	)
"
RDEPEND="${COMMON_DEPEND}
	sonicde-base/sonic-pyside-setup
"
BDEPEND="
"

src_configure() {
	local mycmakeargs=(
		-DBUILD_GEO_SCHEME_HANDLER=ON
		-DUSE_DBUS=$(usex dbus)
		-DWITH_WAYLAND=OFF
		-DWITH_X11=$(usex X)
	)
	ecm_src_configure
}
