# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{12..15} )
inherit python-single-r1

DESCRIPTION="Compatibility package for SonicDE sonic-firewall"
HOMEPAGE="https://github.com/Sonic-DE/sonic-firewall"
LICENSE="metapackage"
SLOT="6/6-sonicde"
KEYWORDS="~amd64 ~arm64 ~loong ~ppc64 ~riscv ~x86"
IUSE+="firewalld +ufw debug test"
REQUIRED_USE="${PYTHON_REQUIRED_USE} || ( firewalld ufw )"
RESTRICT="!test? ( test )"
RDEPEND="${PYTHON_DEPS}
	~sonicde-base/sonic-firewall-${PV}:6[${PYTHON_SINGLE_USEDEP},firewalld=,ufw=,debug=,test=]
"
