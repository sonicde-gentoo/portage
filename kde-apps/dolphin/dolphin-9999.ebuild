# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="File-free compatibility package for SonicDE file manager"
HOMEPAGE="https://github.com/Sonic-DE/sonic-ecco"
LICENSE="metapackage"
SLOT="6/6-sonicde"
IUSE="debug +handbook semantic-desktop telemetry test"

RESTRICT="!test? ( test )"
RDEPEND="~sonicde-base/sonic-ecco-${PV}:6[debug=,handbook=,semantic-desktop=,telemetry=,test=]"
