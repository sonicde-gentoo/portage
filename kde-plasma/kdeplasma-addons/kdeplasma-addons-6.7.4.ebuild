# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Compatibility package for SonicDE sonic-workspace-addons"
HOMEPAGE="https://github.com/Sonic-DE/sonic-workspace-addons"
LICENSE="metapackage"
SLOT="6/6-sonicde"
KEYWORDS="~amd64 ~arm64 ~loong ~ppc64 ~riscv ~x86"
IUSE="+alternate-calendar led share webengine debug +handbook"

RDEPEND="~sonicde-base/sonic-workspace-addons-${PV}:6[alternate-calendar=,led=,share=,webengine=,debug=,handbook=]"
