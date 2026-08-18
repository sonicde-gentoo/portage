# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

ECM_DESIGNERPLUGIN="true"
ECM_PYTHON_BINDINGS="off"
QTMIN=6.10.1
inherit ecm frameworks.sonic

DESCRIPTION="Framework for managing menu and toolbar actions in an abstract way"

LICENSE="LGPL-2+"

# slot op: includes QtCore/private/qlocale_p.h
DEPEND="
	>=dev-qt/qtbase-${QTMIN}:6=[dbus,gui,network,ssl,widgets,xml]
	=sonicde-frameworks/sonic-frameworks-settings-${KDE_CATV}*:6
	=sonicde-frameworks/sonic-frameworks-settings-ui-${KDE_CATV}*:6
	=sonicde-frameworks/sonic-frameworks-core-addons-${KDE_CATV}*:6
	=sonicde-frameworks/sonic-frameworks-keybind-${KDE_CATV}*:6
	=sonicde-frameworks/sonic-frameworks-gui-addons-${KDE_CATV}*:6
	=sonicde-frameworks/sonic-frameworks-internationalization-${KDE_CATV}*:6
	=sonicde-frameworks/sonic-frameworks-icon-themes-${KDE_CATV}*:6
	=sonicde-frameworks/sonic-frameworks-data-views-${KDE_CATV}*:6
	=sonicde-frameworks/sonic-frameworks-widgets-addons-${KDE_CATV}*:6
"
RDEPEND="${DEPEND}"

CMAKE_SKIP_TESTS=(
	# bug 668198: files are missing; whatever.
	ktoolbar_unittest
	# bug 650290
	kxmlgui_unittest
	# bug 808216
	ktooltiphelper_unittest
)
