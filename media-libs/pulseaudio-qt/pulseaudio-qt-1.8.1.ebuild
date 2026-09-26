# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="File-free compatibility package for SonicDE PulseAudio Qt"
HOMEPAGE="https://github.com/Sonic-DE/sonic-pulseaudio-library"
LICENSE="metapackage"
SLOT="0/5-sonicde"
KEYWORDS="~amd64 ~arm64 ~loong ~ppc64 ~riscv ~x86"
IUSE="debug +handbook doc test"

RESTRICT="!test? ( test )"
RDEPEND="~sonicde-base/sonic-pulseaudio-library-${PV}:0[debug=,handbook=,doc=,test=]"
