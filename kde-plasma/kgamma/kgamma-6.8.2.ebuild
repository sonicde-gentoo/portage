# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Compatibility package for SonicDE sonic-gamma"
HOMEPAGE="https://github.com/Sonic-DE/sonic-gamma"
LICENSE="metapackage"
SLOT="6/6-sonicde"
KEYWORDS="~amd64 ~arm64 ~x86"

RDEPEND="~sonicde-base/sonic-gamma-${PV}:6"
