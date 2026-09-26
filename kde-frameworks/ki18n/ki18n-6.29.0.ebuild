# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..15} )
inherit python-single-r1

DESCRIPTION="Compatibility package for SonicDE sonic-frameworks-internationalization"
HOMEPAGE="https://github.com/Sonic-DE/sonic-frameworks-internationalization"
LICENSE="metapackage"
SLOT="6/6.29-sonicde"
KEYWORDS="~amd64 ~arm64 ~loong ~ppc64 ~riscv ~x86"
IUSE+="debug"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"
RDEPEND="${PYTHON_DEPS}
	~sonicde-frameworks/sonic-frameworks-internationalization-${PV}:6[${PYTHON_SINGLE_USEDEP},debug=]
"
