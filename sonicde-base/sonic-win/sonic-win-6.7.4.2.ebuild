# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

ECM_HANDBOOK="optional"
ECM_TEST="true"
KFMIN=6.26.0
QTMIN=6.10.1
inherit ecm plasma.sonic xdg

DESCRIPTION="Flexible, composited X window manager"

LICENSE="GPL-2+"
SLOT="6"
KEYWORDS="~amd64 ~arm64 ~ppc64 ~riscv ~x86"
IUSE="accessibility gles2-only lock +nightlight selinux +shortcuts systemd"

RESTRICT="test"

# qtbase slot op: GuiPrivate use in tabbox
COMMON_DEPEND="
	>=dev-qt/qt5compat-${QTMIN}:6[qml]
	>=dev-qt/qtbase-${QTMIN}:6=[accessibility=,gles2-only=,gui,opengl,widgets,X]
	>=dev-qt/qtdeclarative-${QTMIN}:6
	>=dev-qt/qtsensors-${QTMIN}:6
	>=dev-qt/qtshadertools-${QTMIN}:6
	>=dev-qt/qtsvg-${QTMIN}:6
	>=dev-qt/qttools-${QTMIN}:6[widgets]
	>=sonicde-frameworks/sonic-frameworks-auth-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-settings-utils-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-color-scheme-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-settings-${KFMIN}:6[qml]
	>=sonicde-frameworks/sonic-frameworks-settings-ui-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-core-addons-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-crash-handler-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-dbus-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-qml-bridge-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-keybind-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-gui-addons-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-internationalization-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-idle-tracker-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-addons-downloader-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-notifications-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-package-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-app-info-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-svg-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-widgets-addons-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-windowsystem-${KFMIN}:6=[X]
	>=sonicde-frameworks/sonic-frameworks-xml-gui-${KFMIN}:6
	>=sonicde-base/sonic-silver-${KDE_CATV}:6
	>=sonicde-base/sonic-decoration-${KDE_CATV}:6
	>=sonicde-base/sonic-activities-${KDE_CATV}:6=
	media-libs/fontconfig
	media-libs/freetype
	media-libs/lcms:2
	media-libs/libcanberra
	>=media-libs/libdisplay-info-0.2.0:=
	media-libs/libepoxy
	media-libs/libglvnd
	>=media-libs/mesa-24.1.0_rc1[opengl,X]
	virtual/libudev:=
	x11-libs/libX11
	x11-libs/libXi
	>=x11-libs/libdrm-2.4.116
	>=x11-libs/libxcb-1.10:=
	>=x11-libs/libxkbcommon-1.5.0
	x11-libs/xcb-util-cursor
	x11-libs/xcb-util-keysyms
	x11-libs/xcb-util-wm
	accessibility? ( media-libs/libqaccessibilityclient:6 )
	lock? ( >=sonicde-base/sonic-screenlocker-${KDE_CATV}:6 )
	nightlight? ( >=sonicde-base/sonic-night-light-${KDE_CATV}:6 )
	shortcuts? ( >=sonicde-base/sonic-keybind-daemon-${KDE_CATV}:6 )
"
RDEPEND="${COMMON_DEPEND}
	!sonicde-base/sonic-workspace-addons:5
	>=sonicde-frameworks/sonic-frameworks-quick-ui-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-data-models-${KFMIN}:6
	>=kde-plasma/aurorae-${KDE_CATV}:6
	>=sonicde-base/sonic-interface-libraries-${KDE_CATV}:6
	sys-apps/hwdata
	>=x11-base/xwayland-23.1.0
	selinux? ( sec-policy/selinux-wm )
"
DEPEND="${COMMON_DEPEND}
	>=dev-qt/qtbase-${QTMIN}:6[concurrent]
	x11-base/xorg-proto
	x11-libs/xcb-util-image
"
BDEPEND="
	>=dev-qt/qtbase-${QTMIN}:6
	>=sonicde-frameworks/sonic-frameworks-settings-utils-${KFMIN}:6
"

src_prepare() {
	ecm_src_prepare

	# TODO: try to get a build switch upstreamed
	if ! use systemd; then
		sed -e "s/^pkg_check_modules.*libsystemd/#&/" -i CMakeLists.txt || die
	fi
}

src_configure() {
	local mycmakeargs=(
		# KWIN_BUILD_NOTIFICATIONS exists, but kdeclarative still hard-depends on it
		$(cmake_use_find_package accessibility QAccessibilityClient6)
		-DKWIN_BUILD_SCREENLOCKER=$(usex lock)
		-DKWIN_BUILD_NIGHTLIGHT=$(usex nightlight)
		-DKWIN_BUILD_GLOBALSHORTCUTS=$(usex shortcuts)
	)

	ecm_src_configure
}
