# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Compatibility package for SonicDE sonic-login-manager"
HOMEPAGE="https://github.com/Sonic-DE/sonic-login-manager"
LICENSE="metapackage"
SLOT="0/0-sonicde"
KEYWORDS="~amd64 ~arm64 ~loong ~ppc64 ~riscv ~x86"
IUSE="s6 systemd test debug"
REQUIRED_USE="?? ( s6 systemd )"
RESTRICT="!test? ( test )"
RDEPEND="=sonicde-base/sonic-login-manager-6.7.3*:6[s6=,systemd=,test=,debug=]"
