# Copyright 2025-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

ECM_TEST="true"
KFMIN=6.26.0
QTMIN=6.10.1
inherit ecm plasma.sonic xdg

DESCRIPTION="Helpers for scheduling the dark-light cycle"

LICENSE="BSD CC0-1.0 || ( GPL-2 GPL-3 ) || ( LGPL-2.1 LGPL-3 )"
SLOT="6"

DEPEND="
	>=dev-qt/qtbase-${QTMIN}:6[dbus,gui]
	>=dev-qt/qtpositioning-${QTMIN}:6
	>=sonicde-frameworks/sonic-frameworks-settings-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-core-addons-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-dbus-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-holidays-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-internationalization-${KFMIN}:6
"
RDEPEND="${DEPEND}
	sonicde-base/sonic-daemon
	sonicde-base/sonic-screen
	sonicde-base/sonic-system-monitor-library
	sonicde-frameworks/sonic-frameworks-keyring
	sonicde-frameworks/sonic-frameworks-qml-bridge
	sonicde-frameworks/sonic-frameworks-status-notification
	sonicde-frameworks/sonic-frameworks-text-editor
	sonicde-frameworks/sonic-frameworks-text-widgets
	sonicde-frameworks/sonic-frameworks-ui-components
"
