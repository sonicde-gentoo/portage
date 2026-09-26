# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

ECM_HANDBOOK="forceoptional"
KFMIN=6.26.0
QTMIN=6.10.1
inherit ecm plasma.sonic optfeature xdg

DESCRIPTION="Extra Plasma applets and engines"
LICENSE="GPL-2 LGPL-2"
SLOT="6"
KEYWORDS="~amd64 ~arm64 ~loong ~ppc64 ~riscv ~x86"
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
		sonicde-base/sonic-polkit:0
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
RDEPEND+=" !<kde-plasma/kdeplasma-addons-6.7.3 !kde-plasma/kdeplasma-addons:6/6"
PDEPEND+=" ~kde-plasma/kdeplasma-addons-6.7.3:6/6-sonicde"

src_prepare() {
	ecm_src_prepare
	if ! use led; then
		cmake_comment_add_subdirectory kdeds
	fi
}

src_configure() {
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
