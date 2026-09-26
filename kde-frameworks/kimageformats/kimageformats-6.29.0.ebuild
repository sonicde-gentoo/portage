# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Compatibility package for SonicDE sonic-frameworks-image-formats"
HOMEPAGE="https://github.com/Sonic-DE/sonic-frameworks-image-formats"
LICENSE="metapackage"
SLOT="6/6.29-sonicde"
KEYWORDS="~amd64 ~arm64 ~loong ~ppc64 ~riscv ~x86"
IUSE="debug avif eps heif jpeg2k jpegxl openexr raw"

RDEPEND="~sonicde-frameworks/sonic-frameworks-image-formats-${PV}:6[debug=,avif=,eps=,heif=,jpeg2k=,jpegxl=,openexr=,raw=]"
