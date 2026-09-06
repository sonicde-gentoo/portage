# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

ECM_TEST="true"
KFMIN=6.26.0
QTMIN=6.10.1
inherit ecm plasma.sonic xdg

DESCRIPTION="Monitor system sensors, process information and other system resources"
HOMEPAGE="https://apps.kde.org/plasma-systemmonitor/"

LICENSE="|| ( GPL-3 GPL-2 )"
SLOT="6"
KEYWORDS="~amd64 ~arm64 ~ppc64 ~riscv ~x86"

DEPEND="
	>=sonicde-frameworks/sonic-frameworks-quick-ui-addons-1.1.0:6
	>=dev-qt/qtbase-${QTMIN}:6[dbus,gui,widgets]
	>=dev-qt/qtdeclarative-${QTMIN}:6
	>=sonicde-frameworks/sonic-frameworks-settings-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-core-addons-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-crash-handler-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-dbus-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-keybind-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-internationalization-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-icon-themes-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-io-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-data-models-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-addons-downloader-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-package-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-app-info-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-windowsystem-${KFMIN}:6
"
RDEPEND="${DEPEND}
	>=sonicde-frameworks/sonic-frameworks-quick-ui-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-data-models-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-quick-charts-${KFMIN}:6
	>=sonicde-base/sonic-system-stats-${KDE_CATV}:6
	sonicde-frameworks/sonic-frameworks-open-collab
	sonicde-frameworks/sonic-frameworks-qml-bridge
"

CMAKE_SKIP_TESTS=(
	# bug 977514, problem when running with translations available
	TestPageManager
)
