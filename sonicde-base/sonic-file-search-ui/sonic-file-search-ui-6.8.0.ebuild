# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

ECM_TEST="true"
KFMIN=6.30.0
QTMIN=6.11.0
inherit ecm plasma.sonic

DESCRIPTION="Dedicated search application built on top of Baloo"
LICENSE="GPL-2 LGPL-2.1"
SLOT="6"
KEYWORDS="~amd64 ~arm64 ~loong ~ppc64 ~riscv ~x86"

DEPEND="
	>=dev-qt/qtbase-${QTMIN}:6[gui,widgets]
	>=dev-qt/qtdeclarative-${QTMIN}:6
	>=sonicde-frameworks/sonic-frameworks-settings-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-internationalization-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-runner-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-svg-${KFMIN}:6
	>=sonicde-base/sonic-interface-libraries-${KDE_CATV}:6=
"
RDEPEND="${DEPEND}"
RDEPEND+=" !<kde-plasma/milou-6.8.0 !kde-plasma/milou:6/6"
PDEPEND+=" ~kde-plasma/milou-6.8.0:6/6-sonicde"
