# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CARGO_OPTIONAL=1
CRATES="
"
RUST_MIN_VER="1.87.0"

ECM_HANDBOOK="forceoptional"
KFMIN=6.26.0
QTMIN=6.10.1
inherit cargo ecm flag-o-matic plasma.sonic optfeature xdg

DESCRIPTION="Extra Plasma applets and engines"

if [[ ${KDE_BUILD_TYPE} == release ]] && [[ ${PKGBUMPING} != ${PVR} ]]; then
	SRC_URI+=" https://github.com/gentoo-crate-dist/kdeplasma-addons/releases/download/v${PV}/kdeplasma-addons-${PV}-crates.tar.xz -> ${P}-crates.tar.xz"
fi

LICENSE="GPL-2 LGPL-2"
# Dependent crate licenses
LICENSE+=" GPL-3 MIT Unicode-3.0 ZLIB"
SLOT="6"
IUSE="+alternate-calendar led share webengine"

RESTRICT="test" # bug 727846, +missing selenium-webdriver-at-spi

DEPEND="
	>=dev-qt/qtbase-${QTMIN}:6[dbus,gui,network,widgets]
	>=dev-qt/qtdeclarative-${QTMIN}:6
	>=sonicde-frameworks/sonic-frameworks-settings-utils-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-settings-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-settings-ui-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-core-addons-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-qml-bridge-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-keybind-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-gui-addons-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-holidays-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-internationalization-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-io-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-progress-ui-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-addons-downloader-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-notifications-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-package-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-runner-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-app-info-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-svg-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-unit-conversion-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-widgets-addons-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-xml-gui-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-spell-check-${KFMIN}:6
	>=sonicde-base/sonic-interface-libraries-${KDE_CATV}:6=
	alternate-calendar? ( dev-libs/icu:= )
	led? (
		>=sonicde-frameworks/sonic-frameworks-auth-${KFMIN}:6
		>=sonicde-frameworks/sonic-frameworks-dbus-${KFMIN}:6
	)
	share? ( >=sonicde-frameworks/sonic-frameworks-purpose-${KFMIN}:6 )
	webengine? ( >=dev-qt/qtwebengine-${QTMIN}:6 )
"
RDEPEND="${DEPEND}
	!<sonicde-base/sonic-workspace-6.4.80
	sonicde-frameworks/sonic-frameworks-quick-ui-addons:6
	>=dev-qt/qtquick3d-${QTMIN}:6
	>=sonicde-frameworks/sonic-frameworks-quick-ui-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-data-models-${KFMIN}:6
"
BDEPEND="
	led? (
		${RUST_DEPEND}
		dev-build/corrosion
	)
"

pkg_setup() {
	use led && rust_pkg_setup
}

src_prepare() {
	ecm_src_prepare
	# TODO: upstream build switch?
	if ! use led; then
		cmake_comment_add_subdirectory kdeds
		ecm_punt_bogus_dep Corrosion
		ecm_punt_bogus_dep KF6 Auth
		ecm_punt_bogus_dep KF6 DBusAddons
	fi
}

src_configure() {
	# Rust extensions are incompatible with C/C++ LTO compiler see e.g.
	# https://bugs.gentoo.org/910220
	filter-lto

	local mycmakeargs=(
		$(cmake_use_find_package alternate-calendar ICU)
		$(cmake_use_find_package share KF6Purpose)
		$(cmake_use_find_package webengine Qt6WebEngineQuick)
	)

	ecm_src_configure
}

pkg_postinst() {
	optfeature "Disk quota applet" "sys-fs/quota"
	xdg_pkg_postinst
}
