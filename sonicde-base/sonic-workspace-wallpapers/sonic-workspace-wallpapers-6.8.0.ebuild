# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

QTMIN=6.11.0
inherit cmake plasma.sonic

DESCRIPTION="Wallpapers for the Plasma workspace"
LICENSE="GPL-2"
SLOT="6"
KEYWORDS="~amd64 ~arm64 ~loong ~ppc64 ~riscv ~x86"

BDEPEND="
	>=dev-qt/qtbase-${QTMIN}:6
	>=sonicde-frameworks/sonic-frameworks-cmake-modules-6.30.0:0
"
RDEPEND+=" !<kde-plasma/plasma-workspace-wallpapers-6.8.0 !kde-plasma/plasma-workspace-wallpapers:6/6"
PDEPEND+=" ~kde-plasma/plasma-workspace-wallpapers-6.8.0:6/6-sonicde"
