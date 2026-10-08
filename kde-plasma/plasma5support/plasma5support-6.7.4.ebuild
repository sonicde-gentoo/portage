# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="File-free compatibility package for SonicDE Plasma5Support"
HOMEPAGE="https://github.com/Sonic-DE/sonic-plasma5-support-library"
LICENSE="metapackage"
SLOT="6/6-sonicde"
KEYWORDS="~amd64 ~arm64 ~loong ~ppc64 ~riscv ~x86"
IUSE="activities geolocation ksysguard debug doc test"
RESTRICT="test"

RDEPEND="~sonicde-base/sonic-plasma5-support-library-${PV}:6[activities=,geolocation=,ksysguard=,debug=,doc=,test=]"
