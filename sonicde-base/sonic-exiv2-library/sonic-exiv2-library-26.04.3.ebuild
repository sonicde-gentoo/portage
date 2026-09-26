# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

KFMIN=6.22.0
QTMIN=6.10.1
inherit ecm sonic

DESCRIPTION="Wrapper around exiv2 library"
HOMEPAGE="https://github.com/Sonic-DE/sonic-exiv2-library"
SRC_URI="https://github.com/Sonic-DE/sonic-exiv2-library/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/sonic-exiv2-library-${PV}"
LICENSE="GPL-2+"
SLOT="6"
KEYWORDS="~amd64 ~arm64 ~loong ~ppc64 ~riscv ~x86"
IUSE="+xmp"

DEPEND="
	>=dev-qt/qtbase-${QTMIN}:6[gui]
	>=media-gfx/exiv2-0.27:=[xmp=]
"
RDEPEND="${DEPEND}

"
RDEPEND+=" !<kde-apps/libkexiv2-26.04.3 !kde-apps/libkexiv2:6/6"
PDEPEND+=" ~kde-apps/libkexiv2-26.04.3:6/6-sonicde"
