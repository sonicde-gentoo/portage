# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Compatibility package for SonicDE sonic-frameworks-networkmanager"
HOMEPAGE="https://github.com/Sonic-DE/sonic-frameworks-networkmanager"
LICENSE="metapackage"
SLOT="6/6.28-sonicde"
KEYWORDS="~amd64 ~arm64 ~loong ~ppc64 ~riscv ~x86"
IUSE="debug teamd"

RDEPEND="~sonicde-frameworks/sonic-frameworks-networkmanager-${PV}:6[debug=,teamd=]"
