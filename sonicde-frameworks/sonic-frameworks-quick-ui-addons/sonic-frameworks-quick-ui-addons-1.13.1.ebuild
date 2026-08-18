# Copyright 2021-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# TODO: ECMGenerateQDoc
ECM_TEST="true"
KFMIN=6.27.0
QTMIN=6.10.1
inherit ecm sonic

SRC_URI="https://github.com/Sonic-DE/sonic-frameworks-quick-ui-addons/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/sonic-frameworks-quick-ui-addons-${PV}"
KEYWORDS="~amd64 ~arm64 ~loong ~ppc64 ~riscv ~x86"

DESCRIPTION="Visual end user components for Kirigami-based applications"
HOMEPAGE="https://github.com/Sonic-DE/sonic-frameworks-quick-ui-addons"

LICENSE="|| ( GPL-2 GPL-3 LGPL-3 ) LGPL-2.1+"
SLOT="6"

# would profit from VIRTUALX_REQUIRED=test, but then still requires
# org.qt-project.qt.mediaplayer service and fails, bug 911186
RESTRICT="test"

COMMON_DEPEND="
	>=dev-qt/qtbase-${QTMIN}:6[gui]
	>=dev-qt/qtdeclarative-${QTMIN}:6
	>=sonicde-frameworks/sonic-frameworks-color-scheme-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-settings-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-core-addons-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-crash-handler-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-keybind-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-gui-addons-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-internationalization-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-icon-themes-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-quick-ui-${KFMIN}:6
"
RDEPEND="${COMMON_DEPEND}
	>=dev-qt/qtmultimedia-${QTMIN}:6[qml]
	>=sonicde-frameworks/sonic-frameworks-quick-desktop-style-${KFMIN}:6
	sonicde-base/sonic-interface-libraries:6=
"
DEPEND="${COMMON_DEPEND}
	test? (
		>=dev-qt/qtmultimedia-${QTMIN}:6[qml]
		x11-themes/sound-theme-freedesktop
	)
"