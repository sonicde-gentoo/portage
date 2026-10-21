# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Compatibility package for SonicDE sonic-system-info"
HOMEPAGE="https://github.com/Sonic-DE/sonic-system-info"
LICENSE="metapackage"
SLOT="6/6-sonicde"
KEYWORDS="~amd64 ~arm64 ~loong ~ppc64 ~riscv ~x86"
IUSE="gles2-only usb debug +handbook"

RDEPEND="~sonicde-base/sonic-system-info-${PV}:6[gles2-only=,usb=,debug=,handbook=]"
