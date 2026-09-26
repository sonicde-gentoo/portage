# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Compatibility package for SonicDE sonic-frameworks-user-feedback"
HOMEPAGE="https://github.com/Sonic-DE/sonic-frameworks-user-feedback"
LICENSE="metapackage"
SLOT="6/6.30-sonicde"
KEYWORDS="~amd64 ~arm64 ~loong ~ppc64 ~riscv ~x86"
IUSE="doc tools debug test"

RESTRICT="!test? ( test )"
RDEPEND="~sonicde-frameworks/sonic-frameworks-user-feedback-${PV}:6[doc=,tools=,debug=,test=]"
