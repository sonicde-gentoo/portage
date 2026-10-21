# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Compatibility package for SonicDE sonic-power-management"
HOMEPAGE="https://github.com/Sonic-DE/sonic-power-management"
LICENSE="metapackage"
SLOT="6/6-sonicde"
KEYWORDS="~amd64 ~arm64 ~x86"
IUSE="brightness-control filecaps"

RDEPEND="~sonicde-base/sonic-power-management-${PV}:6[brightness-control=,filecaps=]"
