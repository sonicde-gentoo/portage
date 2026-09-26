# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Compatibility package for SonicDE sonic-frameworks-doctools"
HOMEPAGE="https://github.com/Sonic-DE/sonic-frameworks-doctools"
LICENSE="metapackage"
SLOT="6/6.29-sonicde"
KEYWORDS="~amd64 ~arm64 ~loong ~ppc64 ~riscv ~x86"
IUSE="debug nls"

RDEPEND="~sonicde-frameworks/sonic-frameworks-doctools-${PV}:6[debug=,nls=]"
