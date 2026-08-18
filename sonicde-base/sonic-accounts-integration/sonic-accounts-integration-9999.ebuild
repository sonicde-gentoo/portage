# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

ECM_TEST="forceoptional"
KFMIN=6.22.0
PVCUT=$(ver_cut 1-3)
QTMIN=6.10.1
VIRTUALDBUS_TEST="true"
inherit ecm sonic

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/Sonic-DE/sonic-accounts-integration.git"
else
	SRC_URI="https://github.com/Sonic-DE/sonic-accounts-integration/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}/sonic-accounts-integration-${PV}"
fi

DESCRIPTION="Administer web accounts for the sites and services across the Plasma desktop"
HOMEPAGE="https://github.com/Sonic-DE/sonic-accounts-integration"

LICENSE="LGPL-2.1"
SLOT="6"

# bug #549444
RESTRICT="test"

COMMON_DEPEND="
	>=dev-qt/qtbase-${QTMIN}:6[gui,widgets]
	>=dev-qt/qtdeclarative-${QTMIN}:6
	>=sonicde-frameworks/sonic-frameworks-settings-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-core-addons-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-dbus-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-internationalization-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-io-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-keyring-${KFMIN}:6
	>=net-libs/accounts-qt-1.17-r2
	>=sonicde-frameworks/sonic-frameworks-sso-8.61-r102
"
DEPEND="${COMMON_DEPEND}
	dev-libs/qcoro
	>=sonicde-frameworks/sonic-frameworks-settings-utils-${KFMIN}:6
"
RDEPEND="${COMMON_DEPEND}
	kde-apps/signon-kwallet-extension:6
	sonicde-base/sonic-qt-accounts-library
"
BDEPEND="sys-devel/gettext"
PDEPEND="kde-apps/kaccounts-providers:6"

src_configure() {
	local mycmakeargs=( -DKF6_COMPAT_BUILD=OFF )
	ecm_src_configure
}