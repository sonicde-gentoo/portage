# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

ECM_DESIGNERPLUGIN="true"
ECM_TEST="false"
QTMIN=6.10.1
inherit ecm frameworks.sonic

DESCRIPTION="Framework for downloading and sharing additional application data"

LICENSE="LGPL-2+"
KEYWORDS="~amd64 ~arm64 ~loong ~ppc64 ~riscv ~x86"
IUSE="opds"

DEPEND="
	>=dev-qt/qtbase-${QTMIN}:6[gui,network,widgets,xml]
	>=dev-qt/qtdeclarative-${QTMIN}:6[widgets]
	=sonicde-frameworks/sonic-frameworks-open-collab-${KDE_CATV}*:6
	=sonicde-frameworks/sonic-frameworks-archive-${KDE_CATV}*:6
	=sonicde-frameworks/sonic-frameworks-settings-${KDE_CATV}*:6
	=sonicde-frameworks/sonic-frameworks-core-addons-${KDE_CATV}*:6
	=sonicde-frameworks/sonic-frameworks-internationalization-${KDE_CATV}*:6
	=sonicde-frameworks/sonic-frameworks-package-${KDE_CATV}*:6
	=sonicde-frameworks/sonic-frameworks-widgets-addons-${KDE_CATV}*:6
	opds? ( =sonicde-frameworks/sonic-frameworks-feeds-${KDE_CATV}*:6 )
"
RDEPEND="${DEPEND}
	>=sonicde-frameworks/sonic-frameworks-settings-utils-${KDE_CATV}:6
	>=sonicde-frameworks/sonic-frameworks-quick-ui-${KDE_CATV}:6
"

src_configure() {
	local mycmakeargs=(
		$(cmake_use_find_package opds KF6Syndication)
	)

	ecm_src_configure
}
