# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Compatibility package for SonicDE sonic-frameworks-xml-gui"
HOMEPAGE="https://github.com/Sonic-DE/sonic-frameworks-xml-gui"
LICENSE="metapackage"
SLOT="6/6.30-sonicde"
KEYWORDS="~amd64 ~arm64 ~loong ~ppc64 ~riscv ~x86"
IUSE="debug designer"

RDEPEND="~sonicde-frameworks/sonic-frameworks-xml-gui-${PV}:6[debug=,designer=]"
