# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="File-free compatibility package for SonicDE Qt accounts"
HOMEPAGE="https://github.com/Sonic-DE/sonic-qt-accounts-library"
LICENSE="metapackage"
SLOT="0/0-sonicde"
KEYWORDS="~amd64 ~arm64 ~loong ~ppc64 ~riscv ~x86"

RDEPEND="~sonicde-base/sonic-qt-accounts-library-${PV}:0"
