# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

ECM_HANDBOOK="optional"
KFMIN=6.27.0
PVCUT=$(ver_cut 1-3)
QTMIN=6.11.2
# This compatibility version uses the published SonicDE 26.08.0 source.
SONIC_SOURCE_VERSION=26.08.0
inherit ecm sonic xdg

DESCRIPTION="Utility for management of disks, partitions and file systems"
HOMEPAGE="https://github.com/Sonic-DE/sonic-partition-manager"
SRC_URI="https://github.com/Sonic-DE/sonic-partition-manager/archive/refs/tags/${SONIC_SOURCE_VERSION}.tar.gz -> ${PN}-${SONIC_SOURCE_VERSION}.tar.gz"

S="${WORKDIR}/sonic-partition-manager-${SONIC_SOURCE_VERSION}"
LICENSE="GPL-3"
SLOT="6"
KEYWORDS="~amd64 ~arm64 ~ppc64 ~x86"

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
	sonicde-base/sonic-polkit:0
	>=sys-libs/kpmcore-26.07:6=
"
RDEPEND="${DEPEND}

	sonicde-base/sonic-polkit
"
RDEPEND+=" !<sys-block/partitionmanager-26.08.1 !sys-block/partitionmanager:6/6"
PDEPEND+=" ~sys-block/partitionmanager-26.08.1:6/6-sonicde"
