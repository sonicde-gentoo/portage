# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Compatibility package for SonicDE sonic-oxygen-icons"
HOMEPAGE="https://github.com/Sonic-DE/sonic-oxygen-icons"
LICENSE="metapackage"
SLOT="6/6.29-sonicde"
KEYWORDS="~amd64 ~arm64 ~loong ~ppc64 ~riscv ~x86"
IUSE="test"

RESTRICT="!test? ( test )"
RDEPEND="~sonicde-base/sonic-oxygen-icons-${PV}:6[test=]"
