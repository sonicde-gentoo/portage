# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

ECM_TEST="true"
inherit ecm frameworks.sonic

DESCRIPTION="Framework to handle super user actions"
LICENSE="LGPL-2"

RDEPEND="
	=sonicde-frameworks/sonic-frameworks-settings-${KDE_CATV}*:6
	=sonicde-frameworks/sonic-frameworks-core-addons-${KDE_CATV}*:6
	=sonicde-frameworks/sonic-frameworks-internationalization-${KDE_CATV}*:6
	=sonicde-frameworks/sonic-frameworks-pseudo-terminal-${KDE_CATV}*:6
	x11-libs/libX11
"
DEPEND="${RDEPEND}
	x11-base/xorg-proto
"
