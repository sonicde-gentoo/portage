# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

KFMIN=6.30.0
QTMIN=6.11.0
inherit ecm plasma.sonic

DESCRIPTION="Oxygen sound theme for the Plasma desktop"
LICENSE="GPL-2+"
SLOT="6"
KEYWORDS="~amd64 ~arm64 ~loong ~ppc64 ~riscv ~x86"
RDEPEND+=" !<kde-plasma/oxygen-sounds-6.8.0 !kde-plasma/oxygen-sounds:6/6"
PDEPEND+=" ~kde-plasma/oxygen-sounds-6.8.0:6/6-sonicde"
