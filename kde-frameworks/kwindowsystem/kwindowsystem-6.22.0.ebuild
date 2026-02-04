# Copyright 1999-2026 Soccera
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Dummy package"
HOMEPAGE=""

SLOT="6"
if [[ ${PV} != 9999* ]]; then
	KEYWORDS="~amd64"
fi
IUSE="X wayland debug test"
RDEPEND="kde-frameworks/sonic-windowsystem"
