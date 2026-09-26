# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="File-free compatibility package for SonicDE sign-on daemon"
HOMEPAGE="https://github.com/Sonic-DE/sonic-frameworks-sso"
LICENSE="metapackage"
SLOT="0/0-sonicde"
KEYWORDS="~amd64 ~arm64 ~loong ~ppc64 ~riscv ~x86"
IUSE="doc test"

RESTRICT="test !test? ( test )"
RDEPEND="~sonicde-frameworks/sonic-frameworks-sso-${PV}:0[doc=,test=]"
