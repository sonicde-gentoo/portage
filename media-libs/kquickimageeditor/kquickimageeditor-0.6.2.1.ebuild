# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="File-free compatibility package for SonicDE image editor"
HOMEPAGE="https://github.com/Sonic-DE/sonic-quick-image-editor"
LICENSE="metapackage"
SLOT="6/6-sonicde"
KEYWORDS="~amd64 ~arm64 ~loong ~ppc64 ~riscv ~x86"
IUSE="debug +opencv test"

RESTRICT="!test? ( test )"
RDEPEND="~sonicde-base/sonic-quick-image-editor-${PV}:6[debug=,opencv=,test=]"
