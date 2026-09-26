# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="File-free compatibility package for SonicDE polkit Qt"
HOMEPAGE="https://github.com/Sonic-DE/sonic-polkit"
LICENSE="metapackage"
SLOT="0/0-sonicde"

RDEPEND="~sonicde-base/sonic-polkit-${PV}:0"
