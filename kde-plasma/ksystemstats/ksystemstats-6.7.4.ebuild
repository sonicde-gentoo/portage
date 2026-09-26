# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Compatibility package for SonicDE sonic-system-stats"
HOMEPAGE="https://github.com/Sonic-DE/sonic-system-stats"
LICENSE="metapackage"
SLOT="6/6-sonicde"
KEYWORDS="~amd64 ~arm64 ~loong ~ppc64 ~riscv ~x86"
IUSE="networkmanager debug +handbook test +filecaps"

RESTRICT="!test? ( test )"
RDEPEND="~sonicde-base/sonic-system-stats-${PV}:6[networkmanager=,debug=,handbook=,test=,filecaps=]"
