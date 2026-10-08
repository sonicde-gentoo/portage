# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="File-free compatibility package for SonicDE graphical kdesu"
HOMEPAGE="https://github.com/Sonic-DE/sonic-terminal-tools"
LICENSE="metapackage"
SLOT="0/0-sonicde"
IUSE="debug"

RDEPEND="~sonicde-base/sonic-terminal-tools-${PV}:6[debug=]"
