# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

ECM_EXAMPLES="true"
ECM_QTHELP="false"
ECM_TEST="true"
QTMIN=6.10.1
inherit ecm frameworks.sonic

DESCRIPTION="QtQuick plugin providing high-performance charts"

LICENSE="LGPL-2+"

DEPEND="
	>=dev-qt/qtbase-${QTMIN}:6[gui]
	>=dev-qt/qtdeclarative-${QTMIN}:6
	>=dev-qt/qtshadertools-${QTMIN}:6
	examples? (
		>=dev-qt/qtbase-${QTMIN}:6[widgets]
		=sonicde-frameworks/sonic-frameworks-qml-bridge-${KDE_CATV}*:6
		=sonicde-frameworks/sonic-frameworks-quick-ui-${KDE_CATV}*:6
	)
"
RDEPEND="${DEPEND}
	examples? ( !${CATEGORY}/${PN}:5[examples(-)] )
"

src_configure() {
	local mycmakeargs=(
		-DBUILD_EXAMPLES=$(usex examples)
	)

	ecm_src_configure
}
