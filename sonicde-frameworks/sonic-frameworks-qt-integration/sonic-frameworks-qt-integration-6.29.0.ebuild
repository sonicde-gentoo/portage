# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

ECM_QTHELP="false"
QTMIN=6.10.1
inherit ecm frameworks.sonic

DESCRIPTION="Framework for integrating Qt applications with KDE Plasma workspaces"

LICENSE="LGPL-2+"
KEYWORDS="~amd64 ~arm64 ~loong ~ppc64 ~riscv ~x86"

# requires running Plasma environment
RESTRICT="test"

RDEPEND="
	>=dev-qt/qtbase-${QTMIN}:6[gui,widgets]
	=sonicde-frameworks/sonic-frameworks-color-scheme-${KDE_CATV}*:6
	=sonicde-frameworks/sonic-frameworks-settings-${KDE_CATV}*:6
	=sonicde-frameworks/sonic-frameworks-internationalization-${KDE_CATV}*:6
	=sonicde-frameworks/sonic-frameworks-icon-themes-${KDE_CATV}*:6
	=sonicde-frameworks/sonic-frameworks-addons-downloader-${KDE_CATV}*:6
	=sonicde-frameworks/sonic-frameworks-notifications-${KDE_CATV}*:6
	=sonicde-frameworks/sonic-frameworks-widgets-addons-${KDE_CATV}*:6
"
DEPEND="${RDEPEND}
	=sonicde-frameworks/sonic-frameworks-package-${KDE_CATV}*:6
"

src_configure() {
	local mycmakeargs=(
		-DCMAKE_DISABLE_FIND_PACKAGE_AppStreamQt=ON
		-DCMAKE_DISABLE_FIND_PACKAGE_packagekitqt6=ON
	)

	ecm_src_configure
}
