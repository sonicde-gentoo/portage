# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

ECM_QTHELP="false"
QTMIN=6.10.1
inherit ecm frameworks.sonic

DESCRIPTION="Style for QtQuickControls 2 that uses QWidget's QStyle for painting"

LICENSE="|| ( GPL-2+ LGPL-3+ )"
KEYWORDS="~amd64 ~arm64 ~loong ~ppc64 ~riscv ~x86"

# Qt_6_PRIVATE_API matches org.kde.desktop.so, see also:
# https://invent.kde.org/frameworks/qqc2-desktop-style/-/merge_requests/379
DEPEND="
	>=dev-qt/qtbase-${QTMIN}:6[dbus,gui,widgets]
	>=dev-qt/qtdeclarative-${QTMIN}:6=
	=sonicde-frameworks/sonic-frameworks-color-scheme-${KDE_CATV}*:6
	=sonicde-frameworks/sonic-frameworks-settings-${KDE_CATV}*:6
	=sonicde-frameworks/sonic-frameworks-icon-themes-${KDE_CATV}*:6
	=sonicde-frameworks/sonic-frameworks-quick-ui-${KDE_CATV}*:6
	=sonicde-frameworks/sonic-frameworks-spell-check-${KDE_CATV}*:6[qml]
"
RDEPEND="${DEPEND}
	>=dev-qt/qt5compat-${QTMIN}:6
"
BDEPEND=">=dev-qt/qttools-${QTMIN}:6[linguist]"

CMAKE_SKIP_TESTS=(
	# bug 926509
	animationspeedmodifiertest
)
