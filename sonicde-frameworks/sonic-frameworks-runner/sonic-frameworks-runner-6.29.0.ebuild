# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

QTMIN=6.10.1
inherit ecm frameworks.sonic

DESCRIPTION="Framework for providing different actions given a string query"

LICENSE="LGPL-2+"
KEYWORDS="~amd64 ~arm64 ~loong ~ppc64 ~riscv ~x86"

DEPEND="
	>=dev-qt/qtbase-${QTMIN}:6[dbus,gui]
	=sonicde-frameworks/sonic-frameworks-settings-${KDE_CATV}*:6
	=sonicde-frameworks/sonic-frameworks-core-addons-${KDE_CATV}*:6
	=sonicde-frameworks/sonic-frameworks-internationalization-${KDE_CATV}*:6
	=sonicde-frameworks/sonic-frameworks-data-models-${KDE_CATV}*:6
	=sonicde-frameworks/sonic-frameworks-windowsystem-${KDE_CATV}*:6
"
RDEPEND="${DEPEND}
	sonicde-frameworks/sonic-frameworks-silver-icons
"

CMAKE_SKIP_TESTS=(
	# requires virtual dbus, otherwise hangs; bugs #630672
	dbusrunnertest
	# bug 789351
	runnermanagersinglerunnermodetest
	# bug 838502
	runnermanagertest
	# bug 926502, needs dbus
	threadingtest
)
