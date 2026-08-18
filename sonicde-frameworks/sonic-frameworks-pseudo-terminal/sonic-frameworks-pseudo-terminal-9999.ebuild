# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit ecm frameworks.sonic

DESCRIPTION="Framework for pseudo terminal devices and running child processes"

LICENSE="LGPL-2+"

DEPEND="
	=sonicde-frameworks/sonic-frameworks-core-addons-${KDE_CATV}*:6
	=sonicde-frameworks/sonic-frameworks-internationalization-${KDE_CATV}*:6
	sys-libs/libutempter
"
RDEPEND="${DEPEND}"

src_configure() {
	local mycmakeargs=(
		-DUTEMPTER_EXECUTABLE="${EPREFIX}/usr/sbin/utempter"
	)

	ecm_src_configure
}
