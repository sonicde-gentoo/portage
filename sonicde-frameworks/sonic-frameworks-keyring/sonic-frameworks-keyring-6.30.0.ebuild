# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

QTMIN=6.10.1
inherit ecm frameworks.sonic

DESCRIPTION="Interface to KWallet Framework providing desktop-wide storage for passwords"
LICENSE="LGPL-2+"
KEYWORDS="~amd64 ~arm64 ~loong ~ppc64 ~riscv ~x86"
IUSE="minimal gpg +keyring +legacy-kwallet +man"

DEPEND="
	dev-libs/libgcrypt:0=
	>=dev-qt/qtbase-${QTMIN}:6[dbus,gui,widgets]
	=sonicde-frameworks/sonic-frameworks-settings-${KDE_CATV}*:6
	!minimal? (
		=sonicde-frameworks/sonic-frameworks-color-scheme-${KDE_CATV}*:6
		=sonicde-frameworks/sonic-frameworks-core-addons-${KDE_CATV}*:6
		=sonicde-frameworks/sonic-frameworks-crash-handler-${KDE_CATV}*:6
		=sonicde-frameworks/sonic-frameworks-dbus-${KDE_CATV}*:6
		=sonicde-frameworks/sonic-frameworks-internationalization-${KDE_CATV}*:6
		=sonicde-frameworks/sonic-frameworks-notifications-${KDE_CATV}*:6
		=sonicde-frameworks/sonic-frameworks-app-info-${KDE_CATV}*:6
		=sonicde-frameworks/sonic-frameworks-widgets-addons-${KDE_CATV}*:6
		=sonicde-frameworks/sonic-frameworks-windowsystem-${KDE_CATV}*:6
		gpg? ( dev-libs/qgpgme:= )
		keyring? ( >=sonicde-base/sonic-crypto-library-2.3.9:2 )
		legacy-kwallet? ( app-crypt/libsecret )
	)
"
RDEPEND="${DEPEND}
"
BDEPEND="man? ( >=sonicde-frameworks/sonic-frameworks-doctools-${KDE_CATV}:6 )"
RDEPEND+=" !<kde-frameworks/kwallet-6.30.0 !kde-frameworks/kwallet:6/6.30"
PDEPEND+=" ~kde-frameworks/kwallet-6.30.0:6/6.30-sonicde"
RDEPEND+=" !minimal? ( !<kde-frameworks/kwallet-runtime-6.30.0 !kde-frameworks/kwallet-runtime:6/6.30 )"
PDEPEND+=" !minimal? ( ~kde-frameworks/kwallet-runtime-6.30.0:6/6.30-sonicde[debug=,gpg=,keyring=,legacy-kwallet=,man=] )"
RDEPEND+=" !minimal? ( keyring? ( !<kde-frameworks/ksecretd-services-6.30.0 !kde-frameworks/ksecretd-services:6/6 ) )"
PDEPEND+=" !minimal? ( keyring? ( ~kde-frameworks/ksecretd-services-6.30.0:6/6-sonicde ) )"

src_configure() {
	local mycmakeargs=(
		$(cmake_use_find_package gpg Gpgmepp)
		$(cmake_use_find_package man KF6DocTools)
	)
	if use minimal; then
		mycmakeargs+=(
			-DBUILD_KSECRETD=OFF
			-DBUILD_KWALLETD=OFF
			-DBUILD_KWALLET_QUERY=OFF
		)
	else
		mycmakeargs+=(
			-DBUILD_KSECRETD=$(usex keyring ON OFF)
			-DBUILD_KWALLETD=$(usex legacy-kwallet ON OFF)
			-DBUILD_KWALLET_QUERY=ON
		)
	fi
	ecm_src_configure
}
