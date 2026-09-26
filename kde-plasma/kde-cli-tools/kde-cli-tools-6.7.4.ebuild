# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Compatibility package for SonicDE sonic-terminal-tools"
HOMEPAGE="https://github.com/Sonic-DE/sonic-terminal-tools"
LICENSE="metapackage"
SLOT="6/6-sonicde"
KEYWORDS="~amd64 ~arm64 ~loong ~ppc64 ~riscv ~x86"
IUSE="debug"
RDEPEND="~sonicde-base/sonic-terminal-tools-${PV}:6[debug=]"
