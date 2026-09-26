# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

ECM_PYTHON_BINDINGS="off"
QTMIN=6.10.1
inherit ecm frameworks.sonic

DESCRIPTION="Framework providing assorted widgets for showing the progress of jobs"
LICENSE="LGPL-2+"
KEYWORDS="~amd64 ~arm64 ~loong ~ppc64 ~riscv ~x86"

# slot op: WITH_X11 uses Qt6::GuiPrivate for qtx11extras_p.h
RDEPEND="
	>=dev-qt/qtbase-${QTMIN}:6[dbus,gui,widgets]
	=sonicde-frameworks/sonic-frameworks-core-addons-${KDE_CATV}*:6
	=sonicde-frameworks/sonic-frameworks-notifications-${KDE_CATV}*:6
	=sonicde-frameworks/sonic-frameworks-widgets-addons-${KDE_CATV}*:6
	>=dev-qt/qtbase-${QTMIN}:6=
"
DEPEND="${RDEPEND}"
BDEPEND=">=dev-qt/qttools-${QTMIN}:6[linguist]"
RDEPEND+=" !<kde-frameworks/kjobwidgets-6.30.0 !kde-frameworks/kjobwidgets:6/6.30"
PDEPEND+=" ~kde-frameworks/kjobwidgets-6.30.0:6/6.30-sonicde"
