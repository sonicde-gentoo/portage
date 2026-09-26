# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Compatibility package for SonicDE sonic-frameworks-purpose"
HOMEPAGE="https://github.com/Sonic-DE/sonic-frameworks-purpose"
LICENSE="metapackage"
SLOT="6/6.29-sonicde"
KEYWORDS="~amd64 ~arm64 ~loong ~ppc64 ~riscv ~x86"
IUSE="bluetooth webengine debug test"

RESTRICT="!test? ( test )"
RDEPEND="~sonicde-frameworks/sonic-frameworks-purpose-${PV}:6[bluetooth=,webengine=,debug=,test=]"
