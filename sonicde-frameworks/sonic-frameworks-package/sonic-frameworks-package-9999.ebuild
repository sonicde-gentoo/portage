# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

QTMIN=6.10.1
inherit ecm frameworks.sonic

DESCRIPTION="Framework to install and load packages of non binary content"

LICENSE="LGPL-2+"
IUSE="man"

DEPEND="
	>=dev-qt/qtbase-${QTMIN}:6[dbus]
	=sonicde-frameworks/sonic-frameworks-archive-${KDE_CATV}*:6
	=sonicde-frameworks/sonic-frameworks-core-addons-${KDE_CATV}*:6
	=sonicde-frameworks/sonic-frameworks-internationalization-${KDE_CATV}*:6
"
RDEPEND="${DEPEND}"
BDEPEND="man? ( >=sonicde-frameworks/sonic-frameworks-doctools-${KDE_CATV}:6 )"

CMAKE_SKIP_TESTS=(
	# bugs 650214, 939041
	plasmoidpackagetest
	# requires network access
	testpackage-appstream
)

src_configure() {
	local mycmakeargs=(
		$(cmake_use_find_package man KF6DocTools)
	)

	ecm_src_configure
}
