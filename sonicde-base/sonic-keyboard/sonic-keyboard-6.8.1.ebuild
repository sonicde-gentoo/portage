# Copyright 2025-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

ECM_TEST="true"
KFMIN=6.30.0
QTMIN=6.11.0
inherit ecm sonic xdg

DESCRIPTION="SonicDE virtual keyboard and Qt input-context plugin"
HOMEPAGE="https://github.com/Sonic-DE/sonic-keyboard"
SRC_URI="https://github.com/Sonic-DE/sonic-keyboard/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${P}"

LICENSE="BSD GPL-3 LGPL-2.1 LGPL-3"
SLOT="6"
KEYWORDS="~amd64 ~arm64 ~loong ~ppc64 ~riscv ~x86"
RESTRICT="!test? ( test )"

# Both the frontend adapter and input-context plugin use Qt private APIs.
COMMON_DEPEND="
	>=dev-qt/qtbase-${QTMIN}:6=[dbus,gui,X]
	>=dev-qt/qtdeclarative-${QTMIN}:6
	>=dev-qt/qtvirtualkeyboard-${QTMIN}:6=
	>=sonicde-frameworks/sonic-frameworks-settings-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-core-addons-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-crash-handler-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-internationalization-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-settings-utils-${KFMIN}:6
	>=sonicde-base/sonic-interface-libraries-6.8.0:6=
	x11-libs/libxkbcommon
"
DEPEND="${COMMON_DEPEND}"
RDEPEND="${COMMON_DEPEND}
	>=sonicde-frameworks/sonic-frameworks-settings-${KFMIN}:6[qml]
	>=sonicde-frameworks/sonic-frameworks-data-models-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-quick-ui-${KFMIN}:6
	sonicde-frameworks/sonic-frameworks-quick-ui-addons:6
	!<kde-plasma/plasma-keyboard-6.8.1
	!kde-plasma/plasma-keyboard:6/6
"
BDEPEND="
	>=sonicde-frameworks/sonic-frameworks-settings-utils-${KFMIN}:6
	virtual/pkgconfig
	test? (
		sys-apps/dbus
		x11-misc/xvfb-run
	)
"
PDEPEND="~kde-plasma/plasma-keyboard-${PV}:6/6-sonicde"
