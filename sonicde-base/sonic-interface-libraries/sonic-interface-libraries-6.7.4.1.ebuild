# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

ECM_QTHELP="false" # TODO: Port to ECMGenerateQDoc
ECM_TEST="true"
KFMIN=6.26.0
QTMIN=6.10.1
inherit ecm plasma.sonic

DESCRIPTION="Plasma library and runtime components based upon KF6 and Qt6"

LICENSE="LGPL-2+"
SLOT="6/7"
KEYWORDS="~amd64 ~arm64 ~ppc64 ~riscv ~x86"
IUSE="activities gles2-only"

RESTRICT="test"

# dev-qt/qtbase slot op: includes qpa/qplatformwindow_p.h, qpa/qplatformwindow.h
# sonicde-frameworks/sonic-frameworks-windowsystem[X]: Unconditional use of KX11Extras
COMMON_DEPEND="
	>=dev-qt/qtbase-${QTMIN}:6=[dbus,gles2-only=,gui,opengl,widgets,X]
	>=dev-qt/qtdeclarative-${QTMIN}:6
	>=dev-qt/qtsvg-${QTMIN}:6
	>=sonicde-frameworks/sonic-frameworks-color-scheme-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-settings-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-core-addons-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-keybind-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-gui-addons-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-internationalization-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-icon-themes-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-io-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-quick-ui-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-notifications-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-package-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-svg-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-widgets-addons-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-windowsystem-${KFMIN}:6[X]
	media-libs/libglvnd
	x11-libs/libX11
	x11-libs/libxcb
	activities? ( =sonicde-base/sonic-activities-${KDE_CATV}*:6= )
	!gles2-only? ( media-libs/libglvnd[X] )
"
DEPEND="${COMMON_DEPEND}
	x11-base/xorg-proto
	test? ( >=sonicde-frameworks/sonic-frameworks-archive-${KFMIN}:6 )
"
RDEPEND="${COMMON_DEPEND}
	!${CATEGORY}/${PN}:5[-kf6compat(-)]
	>=dev-qt/qt5compat-${QTMIN}:6[qml]
	>=sonicde-frameworks/sonic-frameworks-settings-${KFMIN}:6[qml]
	sonicde-frameworks/sonic-frameworks-data-models
	sonicde-frameworks/sonic-frameworks-silver-icons
"
BDEPEND="
	>=dev-qt/qtbase-${QTMIN}:6
"

PATCHES=( "${FILESDIR}/${PN}-6.6.91-activities-optional.patch" )

src_configure() {
	local mycmakeargs=(
		-DENABLE_ACTIVITIES=$(usex activities)
		$(cmake_use_find_package !gles2-only OpenGL)
	)

	ecm_src_configure
}
