# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

QTMIN=6.10.1
inherit ecm frameworks.sonic

DESCRIPTION="Advanced plugin and service introspection"

LICENSE="LGPL-2 LGPL-2.1+"
KEYWORDS="~amd64 ~arm64 ~loong ~ppc64 ~riscv ~x86"
IUSE="+man"

# requires running kde environment
RESTRICT="test"

RDEPEND="
	>=dev-qt/qtbase-${QTMIN}:6[dbus,xml]
	=sonicde-frameworks/sonic-frameworks-settings-${KDE_CATV}*:6
	=sonicde-frameworks/sonic-frameworks-core-addons-${KDE_CATV}*:6
	=sonicde-frameworks/sonic-frameworks-internationalization-${KDE_CATV}*:6
	sonicde-frameworks/sonic-frameworks-cmake-modules
"
DEPEND="${RDEPEND}
	test? ( >=dev-qt/qtbase-${QTMIN}:6[concurrent] )
"
BDEPEND="man? ( >=sonicde-frameworks/sonic-frameworks-doctools-${KDE_CATV}:6 )"

src_configure() {
	local mycmakeargs=(
		$(cmake_use_find_package man KF6DocTools)
	)

	ecm_src_configure
}
