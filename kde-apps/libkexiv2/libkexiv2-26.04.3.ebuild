# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="File-free compatibility package for SonicDE exiv2 bindings"
HOMEPAGE="https://github.com/Sonic-DE/sonic-exiv2-library"
LICENSE="metapackage"
SLOT="6/6-sonicde"
KEYWORDS="~amd64 ~arm64 ~loong ~ppc64 ~riscv ~x86"
IUSE="debug +xmp"

RDEPEND="~sonicde-base/sonic-exiv2-library-${PV}:6[debug=,xmp=]"
