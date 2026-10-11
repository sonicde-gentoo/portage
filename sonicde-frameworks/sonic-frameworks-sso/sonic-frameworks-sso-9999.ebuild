# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

if [[ ${PV} = *9999* ]] ; then
	EGIT_REPO_URI="https://github.com/Sonic-DE/sonic-frameworks-sso.git"
	inherit git-r3
else
	SRC_URI="https://github.com/Sonic-DE/sonic-frameworks-sso/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}/sonic-frameworks-sso-${PV}"
	KEYWORDS="amd64 arm64 ~loong ~ppc64 ~riscv ~x86"
fi

DESCRIPTION="Signon daemon for libaccounts-glib"
HOMEPAGE="https://github.com/Sonic-DE/sonic-frameworks-sso"

LICENSE="LGPL-2.1"
SLOT="0"
# The qt5/qt6 situation is complicated:
# https://gitlab.com/accounts-sso/signon-plugin-oauth2/-/merge_requests/28#note_1689621252
IUSE="doc test"

# tests are brittle; they all pass when stars align, bug 727666
RESTRICT="test !test? ( test )"

RDEPEND="
	dev-qt/qtbase:6[dbus,gui,network,sql,xml]
	net-libs/libproxy
"
DEPEND="${RDEPEND}"
BDEPEND="
	doc? (
		app-text/doxygen[dot]
		dev-qt/qttools:6[assistant]
	)
"

RDEPEND+=" !<net-libs/signond-9999 !net-libs/signond:0/0"
PDEPEND+=" ~net-libs/signond-9999:0/0-sonicde"

src_configure() {
	local mycmakeargs=(
		-DBUILD_SIGNOND=ON
		-DCMAKE_INSTALL_SYSCONFDIR="${EPREFIX}/etc"
	)
	cmake_src_configure
}

pkg_postinst() {
	if [[ -z "${REPLACING_VERSIONS}" ]] && \
		! has_version "kde-apps/signon-kwallet-extension:*"; then
		ewarn "Without kde-apps/signon-kwallet-extension installed, passwords"
		ewarn "will be saved in plaintext!"
	fi
}
