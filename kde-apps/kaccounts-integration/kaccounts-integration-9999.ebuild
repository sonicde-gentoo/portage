# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="File-free compatibility package for SonicDE account integration"
HOMEPAGE="https://github.com/Sonic-DE/sonic-accounts-integration"
LICENSE="metapackage"
SLOT="6/6-sonicde"
IUSE="debug test"

RESTRICT="test"
RDEPEND="~sonicde-base/sonic-accounts-integration-${PV}:6[debug=,test=]"
