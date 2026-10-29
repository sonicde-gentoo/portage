# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

QTMIN=6.10.1
inherit ecm frameworks.sonic

DESCRIPTION="Tells SonicDE components which init system and seat manager the machine runs"
LICENSE="GPL-2+"

DEPEND="
	>=dev-qt/qtbase-${QTMIN}:6[dbus]
	=sonicde-frameworks/sonic-frameworks-logging-${KDE_CATV}*:6
"
RDEPEND="${DEPEND}"
