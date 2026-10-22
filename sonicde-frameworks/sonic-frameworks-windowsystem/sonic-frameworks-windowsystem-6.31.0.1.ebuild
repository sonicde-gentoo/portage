# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

QTMIN=6.11.0
inherit ecm frameworks.sonic

DESCRIPTION="Framework providing access to properties and features of the window manager"
LICENSE="|| ( LGPL-2.1 LGPL-3 ) MIT"
KEYWORDS="~amd64 ~arm64 ~loong ~ppc64 ~riscv ~x86"

RESTRICT="test"

# slot op: Uses Qt6::GuiPrivate for qtx11extras_p.h
# x11-base/xorg-proto: X11/Xlib.h included in public header kkeyserver.h,
#   req. by KF6WindowSystemConfig.cmake; see also bug #939177
RDEPEND="
	>=dev-qt/qtdeclarative-${QTMIN}:6
	>=dev-qt/qtbase-${QTMIN}:6=[gui]
	x11-base/xorg-proto
	x11-libs/libX11
	x11-libs/libXfixes
	x11-libs/libxcb
	x11-libs/xcb-util-keysyms
	x11-libs/xcb-util-wm
"
DEPEND="${RDEPEND}
"
BDEPEND="
	>=dev-qt/qttools-${QTMIN}:6[linguist]
"

DOCS=( docs/README.kstartupinfo )
RDEPEND+=" !<kde-frameworks/kwindowsystem-6.31.0 !kde-frameworks/kwindowsystem:6/6.31"
PDEPEND+=" ~kde-frameworks/kwindowsystem-6.31.0:6/6.31-sonicde"
