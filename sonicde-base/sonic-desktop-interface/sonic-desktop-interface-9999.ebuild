# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

ECM_HANDBOOK="optional"
ECM_TEST="true"
KFMIN=6.26.0
QTMIN=6.10.1
inherit ecm plasma.sonic optfeature xdg

DESCRIPTION="KDE Plasma desktop"
XORGHDRS="plasma-desktop-override-include-dirs-5"
SRC_URI+=" https://dev.gentoo.org/~asturm/distfiles/${XORGHDRS}.tar.xz"

LICENSE="GPL-2" # TODO: CHECK
SLOT="6"
IUSE="ibus input_devices_wacom scim screencast sdl +semantic-desktop webengine"

RESTRICT="test" # missing selenium-webdriver-at-spi

# slot op: Uses Qt6::GuiPrivate for qtx11extras_p.h
# sonicde-frameworks/sonic-frameworks-windowsystem[X]: Uses KX11Extras
# sonicde-base/sonic-workspace[X]: applets/pager/pagermodel.cpp includes xwindowtasksmodel.h
COMMON_DEPEND="
	>=dev-qt/qt5compat-${QTMIN}:6[qml]
	>=dev-qt/qtbase-${QTMIN}:6=[concurrent,dbus,gui,network,sql,widgets,xml,X]
	>=dev-qt/qtdeclarative-${QTMIN}:6
	>=dev-qt/qtshadertools-${QTMIN}:6
	>=dev-qt/qtsvg-${QTMIN}:6
	>=sonicde-frameworks/sonic-frameworks-open-collab-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-archive-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-auth-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-bookmarks-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-settings-utils-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-text-codec-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-autocomplete-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-settings-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-settings-ui-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-core-addons-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-crash-handler-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-dbus-${KFMIN}:6
	>=sonicde-base/sonic-daemon-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-keybind-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-gui-addons-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-internationalization-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-icon-themes-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-io-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-data-models-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-data-views-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-progress-ui-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-addons-downloader-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-notifications-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-notification-settings-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-package-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-ui-components-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-runner-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-app-info-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-svg-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-widgets-addons-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-windowsystem-${KFMIN}:6[X(-)]
	>=sonicde-frameworks/sonic-frameworks-xml-gui-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-device-integration-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-spell-check-${KFMIN}:6
	>=sonicde-base/sonic-win-${KDE_CATV}:6
	>=sonicde-base/sonic-system-monitor-library-${KDE_CATV}:6
	>=sonicde-base/sonic-interface-libraries-${KDE_CATV}:6=
	>=sonicde-base/sonic-activities-${KDE_CATV}:6=
	>=sonicde-base/sonic-activities-stats-${KDE_CATV}:6
	>=sonicde-base/sonic-workspace-${KDE_CATV}:6[screencast?,X(-)]
	>=sonicde-base/sonic-plasma5-support-library-${KDE_CATV}:6
	virtual/libudev:=
	x11-libs/libX11
	x11-libs/libxcb
	x11-libs/libXcursor
	x11-libs/libXi
	x11-libs/libxkbcommon
	x11-libs/libxkbfile
	ibus? (
		app-i18n/ibus
		dev-libs/glib:2
		x11-libs/xcb-util-keysyms
	)
	input_devices_wacom? (
		dev-libs/libwacom:=
		media-libs/libcanberra
	)
	scim? ( app-i18n/scim )
	sdl? ( media-libs/libsdl2[joystick] )
	semantic-desktop? ( >=sonicde-frameworks/sonic-frameworks-file-search-${KFMIN}:6 )
	webengine? (
		sonicde-base/sonic-accounts-integration:6
		>=net-libs/accounts-qt-1.17[qt6(+)]
	)
"
DEPEND="${COMMON_DEPEND}
	dev-libs/boost
	x11-base/xorg-proto
	test? (
		>=sonicde-frameworks/sonic-frameworks-quick-desktop-style-${KFMIN}:6
		>=sonicde-base/sonic-activity-manager-daemon-${KDE_CATV}:6
	)
"
RDEPEND="${COMMON_DEPEND}
	!<sonicde-base/sonic-workspace-6.0.80
	sonicde-frameworks/sonic-frameworks-quick-ui-addons:6
	>=sonicde-frameworks/sonic-frameworks-quick-ui-${KFMIN}:6
	>=sonicde-base/sonic-win-${KDE_CATV}:6[X(-)]
	>=kde-plasma/plasma-mimeapps-list-3
	media-fonts/noto-emoji
	sys-apps/util-linux
	x11-apps/setxkbmap
	x11-misc/xdg-user-dirs
	screencast? ( >=sonicde-base/sonic-pipewire-${KDE_CATV}:6 )
	webengine? ( >=net-libs/signon-oauth2-0.25_p20210102[qt6(+)] )
	sonicde-base/sonic-screenlocker
	sonicde-base/sonic-silver
"
BDEPEND="
	dev-util/intltool
	>=sonicde-frameworks/sonic-frameworks-settings-utils-${KFMIN}:6
	virtual/pkgconfig
"

PATCHES=(
	"${WORKDIR}/${XORGHDRS}/${PN}-6.1.80-override-include-dirs.patch" # downstream patch
)

src_prepare() {
	ecm_src_prepare

	if ! use ibus; then
		sed -e "s/XCB_XCB_FOUND AND XCB_KEYSYMS_FOUND/false/" \
			-i applets/kimpanel/backend/ibus/CMakeLists.txt || die
	fi

	# TODO: try to get a build switch upstreamed
	if ! use scim; then
		sed -e "s/^pkg_check_modules.*SCIM/#&/" -i CMakeLists.txt || die
	fi
}

src_configure() {
	local mycmakeargs=(
		-DBUILD_KCM_MOUSE_X11=ON
		-DBUILD_KCM_TOUCHPAD_X11=ON
		-DXORGLIBINPUT_INCLUDE_DIRS="${WORKDIR}/${XORGHDRS}"/include
		-DXORGSERVER_INCLUDE_DIRS="${WORKDIR}/${XORGHDRS}"/include
		-DCMAKE_DISABLE_FIND_PACKAGE_PackageKitQt6=ON # not packaged
		$(cmake_use_find_package ibus GLIB2)
		-DBUILD_KCM_TABLET=$(usex input_devices_wacom)
		$(cmake_use_find_package sdl SDL2)
		$(cmake_use_find_package semantic-desktop KF6Baloo)
		$(cmake_use_find_package webengine AccountsQt6)
		$(cmake_use_find_package webengine KAccounts6)
	)

	ecm_src_configure
}

src_test() {
	# parallel tests fail, foldermodeltest,positionertest hang, bug #646890
	# test_kio_fonts needs D-Bus, bug #634166
	# lookandfeel-kcmTest is unreliable for a long time, bug #607918
	local myctestargs=(
		-j1
		-E "(foldermodeltest|positionertest|test_kio_fonts|lookandfeel-kcmTest)"
	)

	ecm_src_test
}

src_install() {
	cmake_src_install

	# Provide kde-mimeapps.list with distribution kde-plasma/plasma-mimeapps-list
	rm "${ED}"/usr/share/applications/kde-mimeapps.list || die
}

pkg_postinst() {
	if [[ -z "${REPLACING_VERSIONS}" ]]; then
		optfeature "screen reader support" "app-accessibility/orca"
	fi
	xdg_pkg_postinst
}
