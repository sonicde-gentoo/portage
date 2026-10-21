# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="File-free compatibility package for SonicDE terminal"
HOMEPAGE="https://github.com/Sonic-DE/sonic-terminal"
LICENSE="metapackage"
SLOT="6/6-sonicde"
KEYWORDS="~amd64 ~arm64 ~loong ~ppc64 ~riscv ~x86"
IUSE="debug +handbook test"
RESTRICT="!test? ( test )"
RDEPEND="~sonicde-base/sonic-terminal-${PV}:6[debug=,handbook=,test=]"
