# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

ECM_HANDBOOK="optional"
# TODO: ECMGenerateQDoc
ECM_TEST="true"
PYTHON_COMPAT=( python3_{11..15} )
KFMIN=6.26.0
QTMIN=6.10.1
inherit ecm fcaps plasma.sonic python-any-r1 toolchain-funcs xdg

DESCRIPTION="Flexible, composited X window manager"
LICENSE="GPL-2+"
SLOT="6"
if [[ ${PV} != *9999 ]]; then
	KEYWORDS="~amd64 ~arm64 ~loong ~ppc64 ~riscv ~x86"
fi
IUSE="accessibility gamepad gles2-only lock screencast +shortcuts systemd"

RESTRICT="test"

# qtbase slot op: GuiPrivate use in tabbox, Qt6WaylandClientPrivate for xx-pip-v1
# qtbase: private/qtx11extras_p.h in src/helpers/killer
COMMON_DEPEND="
	>=dev-libs/libei-1.4
	>=dev-libs/libinput-1.28:=
	>=dev-libs/wayland-1.24.0
	>=dev-qt/qt5compat-${QTMIN}:6[qml]
	>=dev-qt/qtbase-${QTMIN}:6=[accessibility=,gles2-only=,gui,libinput,opengl,wayland,widgets]
	>=dev-qt/qtdeclarative-${QTMIN}:6
	>=dev-qt/qtsensors-${QTMIN}:6
	>=dev-qt/qtsvg-${QTMIN}:6
	>=dev-qt/qttools-${QTMIN}:6[widgets]
	>=sonicde-frameworks/sonic-frameworks-auth-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-settings-utils-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-color-scheme-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-settings-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-core-addons-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-crash-handler-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-dbus-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-qml-bridge-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-keybind-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-gui-addons-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-internationalization-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-idle-tracker-${KFMIN}:6=
	>=sonicde-frameworks/sonic-frameworks-addons-downloader-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-notifications-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-package-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-app-info-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-svg-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-widgets-addons-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-windowsystem-${KFMIN}:6=
	>=sonicde-frameworks/sonic-frameworks-xml-gui-${KFMIN}:6
	>=sonicde-base/sonic-decoration-${KDE_CATV}:6
	>=sonicde-base/sonic-night-light-${KDE_CATV}:6
	>=sonicde-base/sonic-activities-${KDE_CATV}:6=
	media-libs/lcms:2
	media-libs/libcanberra
	>=media-libs/libdisplay-info-0.2.0:=
	media-libs/libepoxy
	media-libs/libglvnd
	>=media-libs/mesa-24.1.0_rc1[opengl]
	virtual/libudev:=
	x11-libs/libX11
	x11-libs/libXi
	>=x11-libs/libdrm-2.4.127
	>=x11-libs/libxcb-1.10:=
	>=x11-libs/libxcvt-0.1.1
	>=x11-libs/libxkbcommon-1.5.0
	x11-libs/xcb-util-cursor
	x11-libs/xcb-util-keysyms
	x11-libs/xcb-util-wm
	accessibility? ( media-libs/libqaccessibilityclient:6 )
	gamepad? ( dev-libs/libevdev )
	lock? ( >=sonicde-base/sonic-screenlocker-${KDE_CATV}:6 )
	screencast? ( >=media-video/pipewire-1.2.0:= )
	shortcuts? ( >=sonicde-base/sonic-keybind-daemon-${KDE_CATV}:6 )
	systemd? ( sys-apps/systemd:= )
"
# Sonic: Block on kwin:6/6, Portage must switch to kwin:6/6-sonicde.
RDEPEND="${COMMON_DEPEND}
	!kde-plasma/kdeplasma-addons:5
	!<kde-plasma/kwin-6.3.80
	!kde-plasma/kwin:6/6

	>=sonicde-frameworks/sonic-frameworks-quick-ui-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-data-models-${KFMIN}:6
	>=sonicde-base/sonic-breeze-${KDE_CATV}:6
	>=sonicde-base/sonic-interface-libraries-${KDE_CATV}:6
	sys-apps/hwdata
"
DEPEND="${COMMON_DEPEND}
	>=dev-qt/qtbase-${QTMIN}:6[concurrent]
	x11-base/xorg-proto
	x11-libs/xcb-util-image
"
BDEPEND="
	${PYTHON_DEPS}
	>=sonicde-frameworks/sonic-frameworks-settings-utils-${KFMIN}:6
"
PDEPEND=">=kde-plasma/kwin-6.7.3:6/6-sonicde"

# https://bugs.gentoo.org/941628
# -m 0755 to avoid suid with USE="-filecaps"
FILECAPS=( -m 0755 cap_sys_nice=ep usr/bin/kwin_x11 )
RDEPEND+=" !<kde-plasma/kwin-x11-6.7.3 !kde-plasma/kwin-x11:6/6"
PDEPEND+=" ~kde-plasma/kwin-x11-6.7.3:6/6-sonicde"

pkg_pretend() {
	[[ ${MERGE_TYPE} != binary ]] && tc-check-min_ver gcc 14
}

pkg_setup() {
	[[ ${MERGE_TYPE} != binary ]] && tc-check-min_ver gcc 14
}

src_prepare() {
	ecm_src_prepare

	# TODO: try to get a build switch upstreamed
	if ! use gamepad; then
		sed -e "s/^pkg_check_modules.*libevdev/#&/" -i CMakeLists.txt || die
	fi

	# TODO: try to get a build switch upstreamed
	if ! use screencast; then
		sed -e "s/^pkg_check_modules.*PipeWire/#&/" -i CMakeLists.txt || die
	fi

	# TODO: try to get a build switch upstreamed
	if ! use systemd; then
		sed -e "s/^pkg_check_modules.*libsystemd/#&/" -i CMakeLists.txt || die
	fi
}

src_configure() {
	local mycmakeargs=(
		# KWIN_BUILD_DECORATIONS exists, drops aurorae, breeze
		# KWIN_BUILD_NOTIFICATIONS exists, but kdeclarative still hard-depends on it
		$(cmake_use_find_package accessibility QAccessibilityClient6)
		-DKWIN_BUILD_SCREENLOCKER=$(usex lock)
		-DKWIN_BUILD_GLOBALSHORTCUTS=$(usex shortcuts)
		-DKWIN_BUILD_X11=yes
	)

	ecm_src_configure
}

pkg_postinst() {
	xdg_pkg_postinst
	fcaps_pkg_postinst
}
