# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Compatibility package for SonicDE sonic-frameworks-windowsystem"
HOMEPAGE="https://github.com/Sonic-DE/sonic-frameworks-windowsystem"
LICENSE="metapackage"
IUSE="+X"
REQUIRED_USE="X"
SLOT="6/6.30-sonicde"
KEYWORDS="~amd64 ~arm64 ~loong ~ppc64 ~riscv ~x86"

RDEPEND="~sonicde-frameworks/sonic-frameworks-windowsystem-${PV}:6"
