# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

ECM_HANDBOOK="optional"
ECM_TEST="forceoptional"
KFMIN=6.26.0
QTMIN=6.10.1
inherit ecm plasma.sonic xdg

EGIT_REPO_URI="https://github.com/Sonic-DE/sonic-workspace.git"

DESCRIPTION="Sonic Workspace"
HOMEPAGE="https://github.com/Sonic-DE/sonic-workspace"

# LICENSE is based on Debian's plasma-workspace 4:6.5.4-3 d/copyright file.
LICENSE="GPL-2+ GPL-2 GPL-3+ || ( GPL-2 GPL-3 ) || ( GPL-2 LicenseRef-KDE-Accepted-GPL ) LicenseRef-KDE-Accepted-GPL LGPL-2 LGPL-2+ LGPL-2.1+ LGPL-3+ || ( LGPL-2 GPL-2 LicenseRef-KDE-Accepted-GPL ) || ( LGPL-2.1 LicenseRef-KDE-Accepted-LGPL ) || ( public-domain MIT ) BSD BSD-2 CC0-1.0 MIT FDL-1.2+"
SLOT="6"
if [[ ${PV} != *9999 ]]; then
	KEYWORDS="~amd64 ~arm64 ~loong ~ppc64 ~riscv ~x86"
fi
IUSE="appstream flatpak +fontconfig +ksysguard networkmanager +policykit screencast +semantic-desktop systemd telemetry +wallpaper-metadata +X"

REQUIRED_USE="fontconfig? ( X )"
RESTRICT="test"

# sonicde-frameworks/sonic-frameworks-windowsystem[X]: Uses KX11Extras
# slot op: Uses Qt::GuiPrivate for qtx11extras_p.h
COMMON_DEPEND="
	dev-libs/icu:=
	>=dev-qt/qt5compat-${QTMIN}:6[qml]
	>=dev-qt/qtbase-${QTMIN}:6=[dbus,gui,libinput,network,opengl,sql,sqlite,widgets,xml]
	>=dev-qt/qtdeclarative-${QTMIN}:6[widgets]
	>=dev-qt/qtlocation-${QTMIN}:6
	>=dev-qt/qtpositioning-${QTMIN}:6
	>=dev-qt/qtshadertools-${QTMIN}:6
	>=dev-qt/qtsvg-${QTMIN}:6
	>=sonicde-frameworks/sonic-frameworks-archive-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-auth-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-bookmarks-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-settings-utils-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-color-scheme-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-autocomplete-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-settings-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-settings-ui-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-core-addons-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-crash-handler-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-dbus-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-qml-bridge-${KFMIN}:6
	>=sonicde-base/sonic-daemon-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-keybind-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-gui-addons-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-holidays-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-internationalization-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-icon-themes-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-idle-tracker-${KFMIN}:6
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
	>=sonicde-frameworks/sonic-frameworks-status-notification-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-svg-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-text-editor-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-text-widgets-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-keyring-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-widgets-addons-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-windowsystem-${KFMIN}:6[X?]
	>=sonicde-frameworks/sonic-frameworks-xml-gui-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-barcode-${KFMIN}:6[qml]
	>=sonicde-frameworks/sonic-frameworks-device-integration-${KFMIN}:6
	>=sonicde-base/sonic-silver-${KDE_CATV}:6
	>=sonicde-base/sonic-night-light-${KDE_CATV}:6
	>=sonicde-base/sonic-screen-library-${KDE_CATV}:6
	>=sonicde-base/sonic-interface-libraries-${KDE_CATV}:6=
	>=sonicde-base/sonic-activities-${KDE_CATV}:6=
	>=sonicde-base/sonic-activities-stats-${KDE_CATV}:6
	>=sonicde-base/sonic-win-${KDE_CATV}:6
	media-libs/libcanberra
	sci-libs/libqalculate:=
	sys-apps/dbus
	virtual/zlib:=
	virtual/libudev:=
	appstream? ( >=dev-libs/appstream-1[qt6] )
	flatpak? ( sys-apps/flatpak )
	ksysguard? ( >=sonicde-base/sonic-system-monitor-library-${KDE_CATV}:6 )
	networkmanager? ( >=sonicde-frameworks/sonic-frameworks-networkmanager-${KFMIN}:6 )
	policykit? ( virtual/libcrypt:= )
	semantic-desktop? ( >=sonicde-frameworks/sonic-frameworks-file-search-${KFMIN}:6 )
	systemd? ( sys-apps/systemd:= )
	telemetry? ( >=sonicde-frameworks/sonic-frameworks-user-feedback-${KFMIN}:6 )
	wallpaper-metadata? ( sonicde-base/sonic-exiv2-library:6 )
	X? (
		>=dev-qt/qtbase-${QTMIN}:6=[X]
		>=sonicde-base/sonic-screenlocker-${KDE_CATV}:6
		x11-libs/libICE
		x11-libs/libSM
		x11-libs/libX11
		x11-libs/libXau
		x11-libs/libxcb
		x11-libs/libXcursor
		x11-libs/libXfixes
		x11-libs/libXtst
		x11-libs/xcb-util
		fontconfig? (
			media-libs/fontconfig
			media-libs/freetype
			x11-libs/libXft
			x11-libs/xcb-util-image
		)
	)
"
DEPEND="${COMMON_DEPEND}
	dev-libs/qcoro
	>=dev-qt/qtbase-${QTMIN}:6[concurrent]
	test? ( screencast? ( >=media-video/pipewire-0.3:* ) )
	X? (
		fontconfig? ( x11-libs/libXrender )
		x11-base/xorg-proto
	)
"
# Sonic: Block on conflicting Plasma packages, and in particular
# plasma-workspace:6/6, because Portage needs to switch to
# plasma-workspace:6/6-sonicde.
#
# Sonic: Block <sonic-desktop-6.7.2 because file moved to here:
#     $(get_libdir)/qt6/plugins/plasma/applets/org.kde.plasma.marginsseparator.so
RDEPEND="${COMMON_DEPEND}
	!<sonicde-base/sonic-desktop-interface-6.6.90
	!kde-plasma/plasma-login-sessions:6
	!<sonicde-base/xdg-desktop-portal-sonicde-6.1.90
	!<sonicde-base/sonic-desktop-6.7.2
	app-text/iso-codes
	sonicde-frameworks/sonic-frameworks-quick-ui-addons:6
	>=dev-qt/qttools-${QTMIN}:*[qdbus]
	sonicde-frameworks/sonic-frameworks-io-extras:6
	>=sonicde-frameworks/sonic-frameworks-quick-ui-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-quick-charts-${KFMIN}:6
	>=sonicde-base/sonic-activity-manager-daemon-${KDE_CATV}:6
	>=sonicde-frameworks/sonic-frameworks-root-shell-${KDE_CATV}:*
	>=sonicde-base/sonic-file-search-ui-${KDE_CATV}:6
	>=sonicde-base/sonic-qt-theme-bridge-${KDE_CATV}:6
	sys-apps/dbus
	x11-apps/xmessage
	x11-apps/xprop
	x11-apps/xrdb
	policykit? ( sys-apps/accountsservice )
	screencast? ( >=media-video/pipewire-0.3:* )
	sonicde-base/sonic-polkit
"
BDEPEND="
	>=sonicde-frameworks/sonic-frameworks-settings-utils-${KFMIN}:6
	virtual/pkgconfig
	test? (
		X? ( x11-misc/xdotool )
	)
"

PATCHES=(
	"${FILESDIR}/plasma-workspace-5.22.5-krunner-cwd-at-home.patch" # TODO upstream: KDE-bug 432975, bug 767478
	"${FILESDIR}/plasma-workspace-6.7.3-optional-nm.patch" # in git master
)

src_prepare() {
	ecm_src_prepare

	# Sonic: Unlike plasma-workspace, sonic-workspace doesn't split out
	# the login sessions into a separate plasma-login-sessions ebuild.
	#
	#cmake_comment_add_subdirectory login-sessions

	if ! use policykit; then
		cmake_comment_add_subdirectory -f kcms users
	fi

	if ! use fontconfig; then
		ecm_punt_bogus_dep XCB IMAGE
		sed -e "s/check_X11_lib(Xft)/#&/" -i CMakeLists.txt || die
	fi

	# TODO: try to get build switches upstreamed
	if ! use flatpak; then
		sed -e "s/^pkg_check_modules.*Flatpak/#&/" -i CMakeLists.txt || die
	fi
	if ! use systemd; then
		sed -e "s/^pkg_check_modules.*SYSTEMD/#&/" -i CMakeLists.txt || die
	fi
}

src_configure() {
	local mycmakeargs=(
		-DCMAKE_DISABLE_FIND_PACKAGE_PackageKitQt6=ON # not packaged
		-DGLIBC_LOCALE_GEN=OFF
		-DGLIBC_LOCALE_PREGENERATED=$(usex elibc_glibc)
		$(cmake_use_find_package appstream AppStreamQt)
		$(cmake_use_find_package fontconfig Fontconfig)
		$(cmake_use_find_package fontconfig Freetype)
		$(cmake_use_find_package ksysguard KSysGuard)
		-DBUILD_GEOTIMEZONED=$(usex networkmanager)
		-DBUILD_CAMERAINDICATOR=$(usex screencast)
		$(cmake_use_find_package semantic-desktop KF6Baloo)
		$(cmake_use_find_package telemetry KF6UserFeedback)
		$(cmake_use_find_package wallpaper-metadata KExiv2Qt6)
	)

	ecm_src_configure
}

src_install() {
	ecm_src_install

	# default startup and shutdown scripts
	insinto /etc/xdg/plasma-workspace/env
	doins "${FILESDIR}"/10-agent-startup.sh

	insinto /etc/xdg/plasma-workspace/shutdown
	doins "${FILESDIR}"/10-agent-shutdown.sh
	fperms +x /etc/xdg/plasma-workspace/shutdown/10-agent-shutdown.sh
}

pkg_postinst () {
	xdg_pkg_postinst

	elog "To enable gpg-agent and/or ssh-agent in Plasma sessions,"
	elog "edit ${EPREFIX}/etc/xdg/plasma-workspace/env/10-agent-startup.sh"
	elog "and ${EPREFIX}/etc/xdg/plasma-workspace/shutdown/10-agent-shutdown.sh"
}
