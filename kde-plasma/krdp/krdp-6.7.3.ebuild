# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Compatibility package for SonicDE sonic-rdp-server"
HOMEPAGE="https://github.com/Sonic-DE/sonic-rdp"
LICENSE="metapackage"
SLOT="6/6-sonicde"
KEYWORDS="~amd64 ~arm64 ~loong ~ppc64 ~riscv ~x86"
IUSE="systemd debug examples test"

RESTRICT="!test? ( test )"
RDEPEND="~sonicde-base/sonic-rdp-server-${PV}:6[systemd=,debug=,examples=,test=]"
