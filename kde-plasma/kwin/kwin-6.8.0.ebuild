# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Compatibility package for SonicDE sonic-win"
HOMEPAGE="https://github.com/Sonic-DE/sonic-win"
LICENSE="metapackage"
SLOT="6/6-sonicde"
KEYWORDS="~amd64 ~arm64 ~loong ~ppc64 ~riscv ~x86"
IUSE="accessibility gles2-only lock +nightlight selinux +shortcuts systemd"

RDEPEND="=sonicde-base/sonic-win-${PV}*:6[accessibility=,gles2-only=,lock=,nightlight=,selinux=,shortcuts=,systemd=]"
