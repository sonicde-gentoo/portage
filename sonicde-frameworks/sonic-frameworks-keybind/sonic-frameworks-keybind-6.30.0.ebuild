# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

QTMIN=6.10.1
inherit ecm frameworks.sonic

DESCRIPTION="Framework to handle global shortcuts"
LICENSE="LGPL-2+"
KEYWORDS="~amd64 ~arm64 ~loong ~ppc64 ~riscv ~x86"

# slot op: WITH_X11 uses Qt6::GuiPrivate for qtx11extras_p.h
RDEPEND="
	>=dev-qt/qtbase-${QTMIN}:6[dbus,gui,widgets]
	>=dev-qt/qtbase-${QTMIN}:6=
"
DEPEND="${RDEPEND}"
BDEPEND=">=dev-qt/qttools-${QTMIN}:6[linguist]"
RDEPEND+=" !<kde-frameworks/kglobalaccel-6.30.0 !kde-frameworks/kglobalaccel:6/6.30"
PDEPEND+=" ~kde-frameworks/kglobalaccel-6.30.0:6/6.30-sonicde"
