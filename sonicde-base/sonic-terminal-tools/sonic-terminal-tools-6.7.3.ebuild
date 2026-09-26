# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

ECM_HANDBOOK="false" # Keep upstream handbooks enabled without a new USE flag.
ECM_TEST="false"
KFMIN=6.26.0
QTMIN=6.10.1
inherit ecm plasma.sonic xdg

DESCRIPTION="Tools based on KDE Frameworks 6 to better interact with the system"
LICENSE="GPL-2 FDL-1.2"
SLOT="6"
KEYWORDS="~amd64 ~arm64 ~loong ~ppc64 ~riscv ~x86"

# slot op: kstart Uses Qt6::GuiPrivate for qtx11extras_p.h
DEPEND="
	>=dev-qt/qtbase-${QTMIN}:6[dbus,gui,widgets]
	>=dev-qt/qtsvg-${QTMIN}:6
	>=sonicde-frameworks/sonic-frameworks-core-addons-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-internationalization-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-io-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-app-info-${KFMIN}:6
	>=dev-qt/qtbase-${QTMIN}:6=[gui]
"
RDEPEND="${DEPEND}
	sonicde-frameworks/sonic-frameworks-autocomplete
	sonicde-frameworks/sonic-frameworks-icon-themes
	sonicde-frameworks/sonic-frameworks-root-shell
	sonicde-frameworks/sonic-frameworks-ui-components
	sonicde-frameworks/sonic-frameworks-widgets-addons
	sonicde-frameworks/sonic-frameworks-windowsystem
"
BDEPEND="
	>=sonicde-frameworks/sonic-frameworks-doctools-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-settings-utils-${KFMIN}:6
	sys-devel/gettext
"

# Gentoo compatibility owner transitions.
RDEPEND+=" !<kde-plasma/kde-cli-tools-6.7.3 !kde-plasma/kde-cli-tools:6/6"
PDEPEND+=" ~kde-plasma/kde-cli-tools-6.7.3:6/6-sonicde"
RDEPEND+=" !<kde-plasma/kde-cli-tools-common-${PV} !kde-plasma/kde-cli-tools-common:0/0"
PDEPEND+=" ~kde-plasma/kde-cli-tools-common-${PV}:0/0-sonicde"

src_prepare() {
	ecm_src_prepare
}
