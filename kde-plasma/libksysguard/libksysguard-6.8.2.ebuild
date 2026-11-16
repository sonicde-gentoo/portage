# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Compatibility package for SonicDE sonic-system-monitor-library"
HOMEPAGE="https://github.com/Sonic-DE/sonic-system-monitor-library"
LICENSE="metapackage"
SLOT="6/11-sonicde"
KEYWORDS="~amd64 ~arm64 ~loong ~ppc64 ~riscv ~x86"
IUSE="debug test +filecaps"

RESTRICT="!test? ( test )"
RDEPEND="~sonicde-base/sonic-system-monitor-library-${PV}:6[debug=,test=,filecaps=]"
