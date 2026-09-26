# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Compatibility package for SonicDE sonic-frameworks-app-info"
HOMEPAGE="https://github.com/Sonic-DE/sonic-frameworks-app-info"
LICENSE="metapackage"
SLOT="6/6.30-sonicde"
KEYWORDS="~amd64 ~arm64 ~loong ~ppc64 ~riscv ~x86"
IUSE="debug +man"

RDEPEND="~sonicde-frameworks/sonic-frameworks-app-info-${PV}:6[debug=,man=]"
