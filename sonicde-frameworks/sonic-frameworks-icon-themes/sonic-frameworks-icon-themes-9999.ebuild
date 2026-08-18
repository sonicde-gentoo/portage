# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

ECM_DESIGNERPLUGIN="true"
QTMIN=6.10.1
inherit ecm frameworks.sonic

DESCRIPTION="Framework for icon theming and configuration"

LICENSE="LGPL-2+"

RESTRICT="test" # bug 574770

# slot op: Uses Qt6::GuiPrivate for qiconloader_p.h, qguiapplication_p.h
RDEPEND="
	>=dev-qt/qtbase-${QTMIN}:6=[dbus,gui,widgets]
	>=dev-qt/qtdeclarative-${QTMIN}:6
	>=dev-qt/qtsvg-${QTMIN}:6
	=sonicde-frameworks/sonic-frameworks-silver-icons-${KDE_CATV}*:6
	=sonicde-frameworks/sonic-frameworks-archive-${KDE_CATV}*:6
	=sonicde-frameworks/sonic-frameworks-color-scheme-${KDE_CATV}*:6
	=sonicde-frameworks/sonic-frameworks-settings-${KDE_CATV}*:6
	=sonicde-frameworks/sonic-frameworks-internationalization-${KDE_CATV}*:6
	=sonicde-frameworks/sonic-frameworks-widgets-addons-${KDE_CATV}*:6
"
DEPEND="${RDEPEND}"
