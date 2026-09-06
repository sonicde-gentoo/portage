# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

ECM_QTHELP="false"
inherit ecm frameworks.sonic

DESCRIPTION="Tools to generate documentation in various formats from DocBook files"

LICENSE="MIT"
IUSE="nls"

DEPEND="
	app-text/docbook-xml-dtd:4.5
	app-text/docbook-xsl-stylesheets
	app-text/sgml-common
	dev-libs/libxml2:2=
	dev-libs/libxslt
	=sonicde-frameworks/sonic-frameworks-archive-${KDE_CATV}*:6
"
RDEPEND="${DEPEND}"
BDEPEND="
	dev-lang/perl
	dev-perl/URI
	nls? ( >=sonicde-frameworks/sonic-frameworks-internationalization-${KDE_CATV}:6 )
"

CMAKE_SKIP_TESTS=(
	# bug 665622
	kdoctools_install
)

PATCHES=( "${FILESDIR}/${PN}-5.54.0-gentoo-docbundledir.patch" )

src_configure() {
	local mycmakeargs=(
		$(cmake_use_find_package nls KF6I18n)
	)

	ecm_src_configure
}
