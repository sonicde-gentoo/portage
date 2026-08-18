# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

ECM_TEST="true"
KFMIN=6.16.0
QTMIN=6.8.1
inherit ecm sonic linux-info tmpfiles

SRC_URI="https://github.com/Sonic-DE/sonic-frameworks-io-fuse/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/sonic-frameworks-io-fuse-${PV}"

DESCRIPTION="FUSE interface for KIO"
HOMEPAGE="https://github.com/Sonic-DE/sonic-frameworks-io-fuse"

LICENSE="GPL-3+"
SLOT="6"
KEYWORDS="amd64 arm64 ~loong ~ppc64 ~riscv ~x86"

RESTRICT="test" # depend on fuse kernel module

DEPEND="
	>=dev-qt/qtbase-${QTMIN}:6[dbus,gui,widgets]
	>=sonicde-frameworks/sonic-frameworks-core-addons-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-internationalization-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-io-${KFMIN}:6
	sys-fs/fuse:3=
"
RDEPEND="${DEPEND}
	!${CATEGORY}/${PN}:5
	sonicde-frameworks/sonic-frameworks-io-extras
"

pkg_setup() {
	local CONFIG_CHECK="~FUSE_FS"
	linux-info_pkg_setup
}

pkg_postinst() {
	tmpfiles_process "${PN}-tmpfiles.conf"
}