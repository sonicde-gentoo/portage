# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

QTMIN=6.10.1
inherit ecm frameworks.sonic

DESCRIPTION="Framework providing a full text editor component"

LICENSE="LGPL-2+"
KEYWORDS="~amd64 ~arm64 ~loong ~ppc64 ~riscv ~x86"
IUSE="+editorconfig"

RESTRICT="test"

DEPEND="
	>=dev-qt/qtbase-${QTMIN}:6[gui,widgets]
	>=dev-qt/qtdeclarative-${QTMIN}:6
	>=dev-qt/qtspeech-${QTMIN}:6
	=sonicde-frameworks/sonic-frameworks-archive-${KDE_CATV}*:6
	=sonicde-frameworks/sonic-frameworks-auth-${KDE_CATV}*:6
	=sonicde-frameworks/sonic-frameworks-text-codec-${KDE_CATV}*:6
	=sonicde-frameworks/sonic-frameworks-color-scheme-${KDE_CATV}*:6
	=sonicde-frameworks/sonic-frameworks-autocomplete-${KDE_CATV}*:6
	=sonicde-frameworks/sonic-frameworks-settings-${KDE_CATV}*:6
	=sonicde-frameworks/sonic-frameworks-settings-ui-${KDE_CATV}*:6
	=sonicde-frameworks/sonic-frameworks-core-addons-${KDE_CATV}*:6
	=sonicde-frameworks/sonic-frameworks-gui-addons-${KDE_CATV}*:6
	=sonicde-frameworks/sonic-frameworks-internationalization-${KDE_CATV}*:6
	=sonicde-frameworks/sonic-frameworks-io-${KDE_CATV}*:6
	=sonicde-frameworks/sonic-frameworks-data-views-${KDE_CATV}*:6
	=sonicde-frameworks/sonic-frameworks-progress-ui-${KDE_CATV}*:6
	=sonicde-frameworks/sonic-frameworks-ui-components-${KDE_CATV}*:6
	=sonicde-frameworks/sonic-frameworks-widgets-addons-${KDE_CATV}*:6
	=sonicde-frameworks/sonic-frameworks-xml-gui-${KDE_CATV}*:6
	=sonicde-frameworks/sonic-frameworks-spell-check-${KDE_CATV}*:6
	=sonicde-frameworks/sonic-frameworks-syntax-highlighting-${KDE_CATV}*:6
	editorconfig? ( app-text/editorconfig-core-c )
"
RDEPEND="${DEPEND}"
BDEPEND="test? ( >=sonicde-frameworks/sonic-frameworks-app-info-${KDE_CATV}:6 )"

src_configure() {
	local mycmakeargs=(
		$(cmake_use_find_package editorconfig EditorConfig)
	)

	ecm_src_configure
}
