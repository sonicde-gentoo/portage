# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Compatibility package for SonicDE sonic-frameworks-spell-check"
HOMEPAGE="https://github.com/Sonic-DE/sonic-frameworks-spell-check"
LICENSE="metapackage"
SLOT="6/6.30-sonicde"
KEYWORDS="~amd64 ~arm64 ~loong ~ppc64 ~riscv ~x86"
IUSE="aspell +hunspell qml debug designer"

RDEPEND="~sonicde-frameworks/sonic-frameworks-spell-check-${PV}:6[aspell=,hunspell=,qml=,debug=,designer=]"
