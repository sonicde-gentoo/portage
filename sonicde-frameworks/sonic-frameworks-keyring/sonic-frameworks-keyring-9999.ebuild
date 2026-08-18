# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

QTMIN=6.10.1
inherit ecm frameworks.sonic

DESCRIPTION="Interface to KWallet Framework providing desktop-wide storage for passwords"

LICENSE="LGPL-2+"
IUSE="minimal"

DEPEND="
	>=dev-qt/qtbase-${QTMIN}:6[dbus,gui,widgets]
	=sonicde-frameworks/sonic-frameworks-settings-${KDE_CATV}*:6
"
RDEPEND="${DEPEND}
	sonicde-base/sonic-crypto-library
"
PDEPEND="!minimal? ( kde-frameworks/kwallet-runtime )"

src_configure() {
	local mycmakeargs=(
		-DBUILD_KSECRETD=OFF
		-DBUILD_KWALLETD=OFF
		-DBUILD_KWALLET_QUERY=OFF
	)
	ecm_src_configure
}
