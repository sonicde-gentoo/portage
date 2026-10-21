# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

QTMIN=6.11.0
inherit ecm frameworks.sonic

DESCRIPTION="Framework providing data models to help with tasks such as sorting and filtering"
LICENSE="LGPL-2+"
KEYWORDS="~amd64 ~arm64 ~loong ~ppc64 ~riscv ~x86"

RDEPEND="
	>=dev-qt/qtdeclarative-${QTMIN}:6
"
DEPEND="${RDEPEND}
"
RDEPEND+=" !<kde-frameworks/kitemmodels-6.31.0 !kde-frameworks/kitemmodels:6/6.31"
PDEPEND+=" ~kde-frameworks/kitemmodels-6.31.0:6/6.31-sonicde"

src_test() {
	LC_NUMERIC="C" ecm_src_test # bug 708820
}
