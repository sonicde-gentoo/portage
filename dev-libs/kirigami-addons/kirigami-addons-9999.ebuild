# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="File-free compatibility package for SonicDE Kirigami addons"
HOMEPAGE="https://github.com/Sonic-DE/sonic-frameworks-quick-ui-addons"
LICENSE="metapackage"
SLOT="6/6-sonicde"
IUSE="debug"

RDEPEND="~sonicde-frameworks/sonic-frameworks-quick-ui-addons-${PV}:6[debug=]"
