# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

ECM_PYTHON_BINDINGS="off"
QTMIN=6.10.1
inherit ecm frameworks.sonic

DESCRIPTION="Framework for converting units"

LICENSE="LGPL-2+"

DEPEND="
	>=dev-qt/qtbase-${QTMIN}:6[network]
	=sonicde-frameworks/sonic-frameworks-internationalization-${KDE_CATV}*:6
"
RDEPEND="${DEPEND}"

src_test() {
	local CMAKE_SKIP_TESTS=(
		# bug 623938 - needs internet connection
		convertertest
		# bug 808216 - needs internet connection
		categorytest
		# bug 808216 - unknown, reported upstream
		currencytableinittest
	)

	LC_NUMERIC="C" ecm_src_test # bug 694804
}
