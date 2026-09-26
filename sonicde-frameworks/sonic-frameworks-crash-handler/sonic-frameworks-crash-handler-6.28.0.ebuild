# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

ECM_TEST="forceoptional"
QTMIN=6.10.1
inherit ecm frameworks.sonic

DESCRIPTION="Framework for intercepting and handling application crashes"
LICENSE="LGPL-2+"
KEYWORDS="~amd64 ~arm64 ~loong ~ppc64 ~riscv ~x86"

# requires running Plasma environment
RESTRICT="test"

RDEPEND="
	>=dev-qt/qtbase-${QTMIN}:6[gui]
	=sonicde-frameworks/sonic-frameworks-core-addons-${KDE_CATV}*:6
	x11-libs/libX11
"
DEPEND="${RDEPEND}
	x11-base/xorg-proto
"
BDEPEND=">=dev-qt/qttools-${QTMIN}:6[linguist]"
RDEPEND+=" !<kde-frameworks/kcrash-6.28.0 !kde-frameworks/kcrash:6/6.28"
PDEPEND+=" ~kde-frameworks/kcrash-6.28.0:6/6.28-sonicde"
