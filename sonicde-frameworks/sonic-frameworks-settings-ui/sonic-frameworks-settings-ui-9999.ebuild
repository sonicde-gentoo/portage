# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

ECM_DESIGNERPLUGIN="true"
QTMIN=6.10.1
inherit ecm frameworks.sonic

DESCRIPTION="Framework providing an assortment of configuration-related widgets"

LICENSE="LGPL-2+"

CMAKE_SKIP_TESTS=(
	# bugs: 864250
	kstandardactiontest
	# bug 926497
	klanguagenametest
)

RDEPEND="
	>=dev-qt/qtbase-${QTMIN}:6[dbus,gui,widgets]
	=sonicde-frameworks/sonic-frameworks-text-codec-${KDE_CATV}*:6
	=sonicde-frameworks/sonic-frameworks-color-scheme-${KDE_CATV}*:6
	=sonicde-frameworks/sonic-frameworks-settings-${KDE_CATV}*:6
	=sonicde-frameworks/sonic-frameworks-core-addons-${KDE_CATV}*:6
	=sonicde-frameworks/sonic-frameworks-gui-addons-${KDE_CATV}*:6
	=sonicde-frameworks/sonic-frameworks-internationalization-${KDE_CATV}*:6
	=sonicde-frameworks/sonic-frameworks-widgets-addons-${KDE_CATV}*:6
"
DEPEND="${RDEPEND}
	test? ( =sonicde-frameworks/sonic-frameworks-settings-${KDE_CATV}*:6[dbus] )
"
