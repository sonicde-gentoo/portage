# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Compatibility package for SonicDE sonic-network-manager"
HOMEPAGE="https://github.com/Sonic-DE/sonic-network-manager"
LICENSE="metapackage"
SLOT="6/6-sonicde"
KEYWORDS="~amd64 ~arm64 ~loong ~ppc64 ~riscv ~x86"
IUSE="openconnect teamd debug test"

RESTRICT="!test? ( test )"
RDEPEND="~sonicde-base/sonic-network-manager-${PV}:6[openconnect=,teamd=,debug=,test=]"
