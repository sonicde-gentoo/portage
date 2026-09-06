# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

QTMIN=6.10.1
inherit ecm frameworks.sonic

DESCRIPTION="Framework for managing bookmarks stored in XBEL format"

LICENSE="LGPL-2+"
KEYWORDS="~amd64 ~arm64 ~loong ~ppc64 ~riscv ~x86"

RDEPEND="
	>=dev-qt/qtbase-${QTMIN}:6[gui,widgets,xml]
	=sonicde-frameworks/sonic-frameworks-settings-${KDE_CATV}*:6
	=sonicde-frameworks/sonic-frameworks-core-addons-${KDE_CATV}*:6
	=sonicde-frameworks/sonic-frameworks-icon-themes-${KDE_CATV}*:6
	=sonicde-frameworks/sonic-frameworks-widgets-addons-${KDE_CATV}*:6
"
DEPEND="${RDEPEND}"
BDEPEND=">=dev-qt/qttools-${QTMIN}:6[linguist]"
