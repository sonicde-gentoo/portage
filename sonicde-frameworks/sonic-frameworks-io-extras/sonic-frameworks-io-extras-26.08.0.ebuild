# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

ECM_HANDBOOK="optional"
ECM_TEST="true"
KFMIN=6.22.0
QTMIN=6.10.1
inherit ecm sonic optfeature xdg

SRC_URI="https://github.com/Sonic-DE/sonic-frameworks-io-extras/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/sonic-frameworks-io-extras-${PV}"

DESCRIPTION="KIO plugins present a filesystem-like view of arbitrary data"
HOMEPAGE="https://github.com/Sonic-DE/sonic-frameworks-io-extras"

LICENSE="GPL-2" # TODO: CHECK
SLOT="6"
KEYWORDS="amd64 arm64 ~loong ~ppc64 ~riscv ~x86"
IUSE="activities ios +man mtp nfs +libproxy openexr samba +sftp taglib X"

# requires running Plasma environment
RESTRICT="test"

DEPEND="
	>=dev-qt/qtbase-${QTMIN}:6[dbus,gui,network,widgets,xml]
	>=dev-qt/qtsvg-${QTMIN}:6
	sonicde-base/sonic-exiv2-library:6
	>=sonicde-frameworks/sonic-frameworks-archive-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-settings-utils-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-text-codec-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-settings-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-core-addons-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-dbus-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-internationalization-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-io-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-ui-components-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-app-info-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-xml-gui-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-device-integration-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-syntax-highlighting-${KFMIN}:6
	activities? (
		>=dev-qt/qtbase-${QTMIN}:6[sql]
		sonicde-base/sonic-activities:6=
		sonicde-base/sonic-activities-stats:6
	)
	ios? (
		app-pda/libimobiledevice:=
		app-pda/libplist:=
	)
	libproxy? (
		>=sonicde-frameworks/sonic-frameworks-notifications-${KFMIN}:6
		net-libs/libproxy
	)
	mtp? ( >=media-libs/libmtp-1.1.16:= )
	nfs? ( net-libs/libtirpc:= )
	openexr? ( media-libs/openexr:= )
	samba? (
		>=sonicde-frameworks/sonic-frameworks-zeroconf-${KFMIN}:6
		net-fs/samba[client]
		>=net-libs/kdsoap-2.2.0:=[qt6(+)]
		>=net-libs/kdsoap-ws-discovery-client-0.3.0
	)
	sftp? (
		dev-libs/qcoro
		>=net-libs/libssh-0.9.8:=[sftp]
	)
	taglib? ( >=media-libs/taglib-1.11.1:= )
	X? (
		x11-libs/libX11
		x11-libs/libXcursor
	)
"
RDEPEND="${DEPEND}
	!kde-apps/kio-extras-kf5:5
	!<sonicde-frameworks/sonic-frameworks-io-5.116.0-r2:5
	!kde-frameworks/kio-trash-desktop-file:5
	>=sonicde-base/sonic-daemon-${KFMIN}:6
"
BDEPEND="man? ( dev-util/gperf )"

src_configure() {
	local mycmakeargs=(
		-DBUILD_ACTIVITIES=$(usex activities)
		$(cmake_use_find_package ios IMobileDevice)
		$(cmake_use_find_package ios PList)
		-DWITH_LIBPROXY=$(usex libproxy)
		$(cmake_use_find_package man Gperf)
		$(cmake_use_find_package mtp Libmtp)
		$(cmake_use_find_package nfs TIRPC)
		$(cmake_use_find_package openexr OpenEXR)
		$(cmake_use_find_package samba Samba)
		$(cmake_use_find_package sftp libssh)
		$(cmake_use_find_package taglib Taglib)
		-DWITHOUT_X11=$(usex !X)
	)
	ecm_src_configure
}

pkg_postinst() {
	optfeature "alternative filename search backend" sys-apps/ripgrep
	use samba && xdg_pkg_postinst
}

pkg_postrm() {
	use samba && xdg_pkg_postrm
}
