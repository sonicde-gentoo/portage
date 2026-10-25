# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

KFMIN=6.27.0
QTMIN=6.11.2
# This compatibility version uses the published SonicDE 26.08.0 source.
SONIC_SOURCE_VERSION=26.08.0
inherit ecm sonic

DESCRIPTION="Wrapper around exiv2 library"
HOMEPAGE="https://github.com/Sonic-DE/sonic-exiv2-library"
SRC_URI="https://github.com/Sonic-DE/sonic-exiv2-library/archive/refs/tags/${SONIC_SOURCE_VERSION}.tar.gz -> ${PN}-${SONIC_SOURCE_VERSION}.tar.gz"

S="${WORKDIR}/sonic-exiv2-library-${SONIC_SOURCE_VERSION}"
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
RDEPEND+=" !<kde-apps/libkexiv2-26.08.1 !kde-apps/libkexiv2:6/6"
PDEPEND+=" ~kde-apps/libkexiv2-26.08.1:6/6-sonicde"
