# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

QTMIN=6.10.1
inherit ecm frameworks.sonic

DESCRIPTION="SonicDE logging library: per-program log files and journald output"
LICENSE="GPL-2+"

DEPEND=">=dev-qt/qtbase-${QTMIN}:6"
RDEPEND="${DEPEND}"
