# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="File-free compatibility package for SonicDE partition manager"
HOMEPAGE="https://github.com/Sonic-DE/sonic-partition-manager"
LICENSE="metapackage"
SLOT="6/6-sonicde"
IUSE="debug +handbook"

RDEPEND="~sonicde-base/sonic-partition-manager-${PV}:6[debug=,handbook=]"
