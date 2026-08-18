# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

ECM_TEST="forceoptional"
KFMIN=6.26.0
QTMIN=6.10.1
inherit ecm plasma.sonic

DESCRIPTION="Plugin based library to create window decorations"

LICENSE="|| ( LGPL-2.1 LGPL-3 )"
SLOT="6"

DEPEND="
	>=dev-qt/qtbase-${QTMIN}:6[gui]
	>=sonicde-frameworks/sonic-frameworks-internationalization-${KFMIN}:6
"
RDEPEND="${DEPEND}"
