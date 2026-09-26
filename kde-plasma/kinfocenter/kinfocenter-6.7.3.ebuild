# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Dummy package to pull in sonic-system-info"
HOMEPAGE="https://github.com/Sonic-DE/"
LICENSE="metapackage"
SLOT="6/6-sonicde"
if [[ ${PV} != *9999 ]]; then
	KEYWORDS="~amd64 ~arm64 ~loong ~ppc64 ~riscv ~x86"
fi
IUSE="gles2-only usb debug +handbook"

RDEPEND="=sonicde-base/sonic-system-info-${PV}*:6[gles2-only=,usb=,debug=,handbook=]"
