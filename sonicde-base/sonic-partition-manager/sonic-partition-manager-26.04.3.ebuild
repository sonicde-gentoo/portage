# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

ECM_HANDBOOK="optional"
KFMIN=6.22.0
PVCUT=$(ver_cut 1-3)
QTMIN=6.10.1
inherit ecm sonic xdg

SRC_URI="https://github.com/Sonic-DE/sonic-partition-manager/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/sonic-partition-manager-${PV}"

DESCRIPTION="Utility for management of disks, partitions and file systems"
HOMEPAGE="https://github.com/Sonic-DE/sonic-partition-manager"

LICENSE="GPL-3"
SLOT="6"
KEYWORDS="amd64 arm64 ~loong ~ppc64 ~x86"

DEPEND="
	>=dev-qt/qtbase-${QTMIN}:6[gui,widgets]
	>=sonicde-frameworks/sonic-frameworks-settings-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-settings-ui-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-core-addons-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-crash-handler-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-dbus-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-internationalization-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-io-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-progress-ui-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-widgets-addons-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-windowsystem-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-xml-gui-${KFMIN}:6
	>=sys-auth/polkit-qt-0.175.0[qt6(+)]
	sys-libs/kpmcore:6=
"
RDEPEND="${DEPEND}
	sonicde-base/sonic-polkit
"
