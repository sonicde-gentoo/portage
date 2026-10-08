# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="File-free compatibility package for SonicDE keyring D-Bus services"
HOMEPAGE="https://github.com/Sonic-DE/sonic-frameworks-keyring"
LICENSE="metapackage"
SLOT="6/6-sonicde"
KEYWORDS="~amd64 ~arm64 ~loong ~ppc64 ~riscv ~x86"
IUSE="systemd"

RDEPEND="~sonicde-frameworks/sonic-frameworks-keyring-${PV}:6[keyring,-minimal]"
