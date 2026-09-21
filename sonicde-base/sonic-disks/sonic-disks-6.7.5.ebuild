# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

ECM_HANDBOOK="true"
KFMIN=6.26.0
QTMIN=6.10.1
inherit ecm plasma.sonic xdg

DESCRIPTION="Monitors S.M.A.R.T. capable devices for imminent failure"

LICENSE="|| ( GPL-3 GPL-2 )"
SLOT="6"
KEYWORDS="~amd64 ~arm64 ~ppc64 ~riscv ~x86"

DEPEND="
	>=dev-qt/qtbase-${QTMIN}:6[dbus,gui]
	>=dev-qt/qtdeclarative-${QTMIN}:6
	>=sonicde-frameworks/sonic-frameworks-auth-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-settings-utils-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-settings-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-core-addons-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-dbus-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-qml-bridge-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-internationalization-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-io-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-progress-ui-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-notifications-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-app-info-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-device-integration-${KFMIN}:6
	sys-apps/smartmontools
"
RDEPEND="${DEPEND}
	sonicde-base/sonic-system-info:6
"
BDEPEND=">=sonicde-frameworks/sonic-frameworks-settings-utils-${KFMIN}:6"
