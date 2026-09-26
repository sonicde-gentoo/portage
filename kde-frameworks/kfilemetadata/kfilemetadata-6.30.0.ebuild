# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Compatibility package for SonicDE sonic-frameworks-file-metadata"
HOMEPAGE="https://github.com/Sonic-DE/sonic-frameworks-file-metadata"
LICENSE="metapackage"
SLOT="6/6.30-sonicde"
KEYWORDS="~amd64 ~arm64 ~loong ~ppc64 ~riscv ~x86"
IUSE="debug epub exif ffmpeg mobi pdf taglib"

RDEPEND="~sonicde-frameworks/sonic-frameworks-file-metadata-${PV}:6[debug=,epub=,exif=,ffmpeg=,mobi=,pdf=,taglib=]"
