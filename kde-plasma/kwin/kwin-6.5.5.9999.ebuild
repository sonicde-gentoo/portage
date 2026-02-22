# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Dummy package to pull in sonic-win"
HOMEPAGE="https://github.com/Sonic-DE/"
SRC_URI=""

LICENSE="metapackage"
SLOT="6"
if [[ ${PV} != *9999 ]]; then
	KEYWORDS="~amd64 ~arm64 ~loong ~ppc64 ~riscv ~x86"
fi
IUSE="accessibility gles2-only lock +shortcuts systemd"

RDEPEND="~kde-plasma/sonic-win-${PV}[accessibility=,gles2-only=,lock=,shortcuts=,systemd=]"
DEPEND="${RDEPEND}"
BDEPEND=""
