# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Compatibility package for SonicDE sonic-desktop-interface"
HOMEPAGE="https://github.com/Sonic-DE/sonic-desktop-interface"
LICENSE="metapackage"
SLOT="6/6-sonicde"
KEYWORDS="~amd64 ~arm64 ~loong ~ppc64 ~riscv ~x86"
IUSE="ibus input_devices_wacom scim screencast sdl +semantic-desktop webengine debug +handbook test"

RESTRICT="!test? ( test )"
RDEPEND="=sonicde-base/sonic-desktop-interface-6.7.5*:6[ibus=,input_devices_wacom=,scim=,screencast=,sdl=,semantic-desktop=,webengine=,debug=,handbook=,test=]"
