# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

QTMIN=6.10.1
inherit cmake plasma.sonic

DESCRIPTION="Wallpapers for the Plasma workspace"

LICENSE="GPL-2"
SLOT="6"
KEYWORDS="~amd64 ~arm64 ~ppc64 ~riscv ~x86"

BDEPEND="
	>=dev-qt/qtbase-${QTMIN}:6
	sonicde-frameworks/sonic-frameworks-cmake-modules:0
"
