# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

ECM_TEST="true"
KFMIN=6.26.0
QTMIN=6.10.1
inherit ecm plasma.sonic xdg

DESCRIPTION="Plasma integration for controlling Thunderbolt devices"

LICENSE="|| ( GPL-2 GPL-3+ )"
SLOT="6"
KEYWORDS="~amd64 ~riscv ~x86"

# tests require DBus
RESTRICT="test"

DEPEND="
	>=dev-qt/qtbase-${QTMIN}:6[dbus,gui]
	>=dev-qt/qtdeclarative-${QTMIN}:6
	>=sonicde-frameworks/sonic-frameworks-settings-utils-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-core-addons-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-dbus-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-internationalization-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-notifications-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-app-info-${KFMIN}:6
"
RDEPEND="${DEPEND}
	>=sonicde-frameworks/sonic-frameworks-quick-ui-${KFMIN}:6
	sys-apps/bolt
"
BDEPEND=">=sonicde-frameworks/sonic-frameworks-settings-utils-${KFMIN}:6"
