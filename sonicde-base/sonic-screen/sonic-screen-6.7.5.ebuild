# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

ECM_TEST="forceoptional"
KFMIN=6.26.0
QTMIN=6.10.1
inherit ecm plasma.sonic xdg

DESCRIPTION="KDE Plasma screen management"

LICENSE="GPL-2" # TODO: CHECK
SLOT="6"
KEYWORDS="~amd64 ~arm64 ~ppc64 ~riscv ~x86"
IUSE="X"

COMMON_DEPEND="
	>=dev-qt/qtbase-${QTMIN}:6=[dbus,gui,widgets]
	>=dev-qt/qtdeclarative-${QTMIN}:6[widgets]
	>=sonicde-frameworks/sonic-frameworks-settings-utils-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-settings-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-core-addons-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-crash-handler-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-dbus-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-internationalization-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-svg-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-windowsystem-${KFMIN}:6[X?]
	>=sonicde-frameworks/sonic-frameworks-xml-gui-${KFMIN}:6
	>=sonicde-base/sonic-interface-libraries-${KDE_CATV}:6=
	X? (
		>=dev-qt/qtbase-${QTMIN}:6[X]
		x11-libs/libX11
		x11-libs/libxcb:=
		x11-libs/libXi
	)
"
RDEPEND="${COMMON_DEPEND}
	!ppc64? ( >=sonicde-frameworks/sonic-frameworks-image-formats-${KFMIN}:6[avif] )
	>=sonicde-frameworks/sonic-frameworks-data-models-${KFMIN}:6
	>=sonicde-base/sonic-keybind-daemon-${KDE_CATV}:6
	>=sonicde-base/sonic-plasma5-support-library-${KDE_CATV}:6
"
DEPEND="${COMMON_DEPEND}
"
BDEPEND="
	>=dev-qt/qtbase-${QTMIN}:6
	>=sonicde-frameworks/sonic-frameworks-settings-utils-${KFMIN}:6
	virtual/pkgconfig
"

PATCHES=( "${FILESDIR}/${PN}-6.6.91-with_x11.patch" ) # downstream, obsolete in git master

src_prepare() {
	ecm_src_prepare
	use ppc64 && cmake_comment_add_subdirectory hdrcalibrator # avif masked on big-endian
}

src_configure() {
	local mycmakeargs=(
		-DWITH_X11=$(usex X)
	)
	ecm_src_configure
}
