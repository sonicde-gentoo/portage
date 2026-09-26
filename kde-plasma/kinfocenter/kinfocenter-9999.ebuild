# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Compatibility package for SonicDE sonic-system-info"
HOMEPAGE="https://github.com/Sonic-DE/sonic-system-info"
LICENSE="metapackage"
SLOT="6/6-sonicde"
IUSE="gles2-only usb"
RDEPEND="~sonicde-base/sonic-system-info-9999:6[gles2-only=,usb=]"
