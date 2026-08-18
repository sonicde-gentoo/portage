# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

ECM_DESIGNERPLUGIN="true"
QTMIN=6.10.1
inherit ecm frameworks.sonic

DESCRIPTION="Framework providing an assortment of widgets for displaying and editing text"

LICENSE="LGPL-2+ LGPL-2.1+"
IUSE="speech"

DEPEND="
	>=dev-qt/qtbase-${QTMIN}:6[gui,widgets]
	=sonicde-frameworks/sonic-frameworks-autocomplete-${KDE_CATV}*:6
	=sonicde-frameworks/sonic-frameworks-settings-${KDE_CATV}*:6
	=sonicde-frameworks/sonic-frameworks-core-addons-${KDE_CATV}*:6
	=sonicde-frameworks/sonic-frameworks-internationalization-${KDE_CATV}*:6
	=sonicde-frameworks/sonic-frameworks-widgets-addons-${KDE_CATV}*:6
	=sonicde-frameworks/sonic-frameworks-spell-check-${KDE_CATV}*:6
	speech? ( >=dev-qt/qtspeech-${QTMIN}:6 )
"
RDEPEND="${DEPEND}"

src_configure() {
	local mycmakeargs=(
		-DWITH_TEXT_TO_SPEECH=$(usex speech)
	)

	ecm_src_configure
}
