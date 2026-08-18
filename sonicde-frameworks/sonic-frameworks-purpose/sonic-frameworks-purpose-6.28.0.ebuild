# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

ECM_QTHELP="false"
ECM_TEST="forceoptional"
QTMIN=6.10.1
inherit ecm frameworks.sonic optfeature xdg

DESCRIPTION="Library for providing abstractions to get the developer's purposes fulfilled"

LICENSE="LGPL-2.1+"
KEYWORDS="~amd64 ~arm64 ~loong ~ppc64 ~riscv ~x86"
IUSE="bluetooth webengine"

# requires running environment
RESTRICT="test"

DEPEND="
	>=dev-qt/qtbase-${QTMIN}:6[gui,network,widgets]
	>=dev-qt/qtdeclarative-${QTMIN}:6
	=sonicde-frameworks/sonic-frameworks-settings-${KDE_CATV}*:6
	=sonicde-frameworks/sonic-frameworks-core-addons-${KDE_CATV}*:6
	=sonicde-frameworks/sonic-frameworks-internationalization-${KDE_CATV}*:6
	=sonicde-frameworks/sonic-frameworks-io-${KDE_CATV}*:6
	=sonicde-frameworks/sonic-frameworks-quick-ui-${KDE_CATV}*:6
	=sonicde-frameworks/sonic-frameworks-notifications-${KDE_CATV}*:6
	=sonicde-frameworks/sonic-frameworks-app-info-${KDE_CATV}*:6
	=sonicde-frameworks/sonic-frameworks-barcode-${KDE_CATV}*:6
	webengine? (
		>=dev-qt/qtbase-${QTMIN}:6[dbus]
		sonicde-base/sonic-accounts-integration:6
		>=net-libs/accounts-qt-1.17[qt6(+)]
	)
"
RDEPEND="${DEPEND}
	=sonicde-frameworks/sonic-frameworks-settings-utils-${KDE_CATV}*:6
	=sonicde-frameworks/sonic-frameworks-data-models-${KDE_CATV}*:6
	=sonicde-frameworks/sonic-frameworks-barcode-${KDE_CATV}*:6[qml]
	bluetooth? ( =sonicde-frameworks/sonic-frameworks-bluetooth-${KDE_CATV}*:6 )
	webengine? ( !kde-frameworks/purpose-kaccounts-services )
"
BDEPEND="
	webengine? (
		dev-util/intltool
		sonicde-base/sonic-accounts-integration:6
	)
"

src_prepare() {
	ecm_src_prepare

	use bluetooth ||
		cmake_comment_add_subdirectory -f src/plugins bluetooth
}

src_configure() {
	local mycmakeargs=(
		-DUSE_DBUS=$(usex webengine)
	)

	ecm_src_configure
}

pkg_postinst() {
	if [[ -z "${REPLACING_VERSIONS}" ]]; then
		optfeature "Send through KDE Connect" kde-misc/kdeconnect
	fi
	xdg_pkg_postinst
}
