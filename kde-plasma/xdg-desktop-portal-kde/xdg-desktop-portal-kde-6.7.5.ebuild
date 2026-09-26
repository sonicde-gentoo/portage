# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Compatibility package for SonicDE xdg-desktop-portal-sonicde"
HOMEPAGE="https://github.com/Sonic-DE/xdg-desktop-portal-sonicde"
LICENSE="metapackage"
SLOT="6/6-sonicde"
KEYWORDS="~amd64 ~arm64 ~loong ~ppc64 ~riscv ~x86"
IUSE="debug test"

RESTRICT="!test? ( test )"
RDEPEND="=sonicde-base/xdg-desktop-portal-sonicde-6.7.5*:6[debug=,test=]"
