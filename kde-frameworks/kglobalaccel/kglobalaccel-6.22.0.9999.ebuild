# Copyright 2026 Bryan Gardiner
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Dummy package to pull in sonic-globalaccel"
HOMEPAGE="https://github.com/Sonic-DE/sonic-globalaccel"
SRC_URI=""

LICENSE="metapackage"
SLOT="6/6-sonicde"
if [[ "${PV}" != *9999 ]]; then
	KEYWORDS="~amd64 ~arm64 ~loong ~ppc64 ~riscv ~x86"
fi
IUSE="X"

RDEPEND="~kde-frameworks/sonic-globalaccel-${PV}[X=]"
DEPEND="${RDEPEND}"
BDEPEND=""
