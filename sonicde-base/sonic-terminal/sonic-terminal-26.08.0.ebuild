# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

ECM_HANDBOOK="optional"
ECM_TEST="true"
KFMIN=6.22.0
QTMIN=6.10.1
inherit ecm sonic

SRC_URI="https://github.com/Sonic-DE/sonic-terminal/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/sonic-terminal-${PV}"

DESCRIPTION="KDE's terminal emulator"
HOMEPAGE="https://github.com/Sonic-DE/sonic-terminal"

LICENSE="GPL-2" # TODO: CHECK
SLOT="6"
KEYWORDS="amd64 arm64 ~loong ~ppc64 ~riscv ~x86"
IUSE="X"

DEPEND="
	dev-libs/icu:=
	>=dev-qt/qtbase-${QTMIN}:6[dbus,gui,network,widgets,xml]
	>=dev-qt/qtmultimedia-${QTMIN}:6
	>=sonicde-frameworks/sonic-frameworks-bookmarks-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-settings-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-settings-ui-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-core-addons-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-crash-handler-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-dbus-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-keybind-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-gui-addons-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-internationalization-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-icon-themes-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-io-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-progress-ui-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-addons-downloader-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-notifications-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-notification-settings-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-ui-components-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-pseudo-terminal-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-app-info-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-text-widgets-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-widgets-addons-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-windowsystem-${KFMIN}:6[X?]
	>=sonicde-frameworks/sonic-frameworks-xml-gui-${KFMIN}:6
"
RDEPEND="${DEPEND}
	sonicde-frameworks/sonic-frameworks-doctools
"

src_configure() {
	local mycmakeargs=(
		# kapsule is not yet packaged
		-DWITH_KAPSULE=OFF
		-DWITH_X11=$(usex X)
	)
	ecm_src_configure
}

src_test() {
	# DBusTest: drkonqi process interferes. bug 702690
	# TerminalInterfaceTest: unbelievably flaky, bug 862594 and bug 662756
	local myctestargs=(
		-E "(DBusTest|TerminalInterfaceTest)"
	)

	ecm_src_test
}