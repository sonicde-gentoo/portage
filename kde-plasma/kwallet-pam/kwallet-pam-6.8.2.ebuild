# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Compatibility package for SonicDE sonic-frameworks-keyring-pam"
HOMEPAGE="https://github.com/Sonic-DE/sonic-frameworks-keyring-pam"
LICENSE="metapackage"
SLOT="6/6-sonicde"
KEYWORDS="~amd64 ~arm64 ~loong ~ppc64 ~riscv ~x86"
IUSE="debug"

RDEPEND="~sonicde-frameworks/sonic-frameworks-keyring-pam-${PV}:6[debug=]"
