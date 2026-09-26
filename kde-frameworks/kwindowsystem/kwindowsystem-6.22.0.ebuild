# Copyright 1999-2026 Soccera
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Dummy package"
HOMEPAGE="https://github.com/Sonic-DE/sonic-frameworks-windowsystem"

LICENSE="metapackage"
SLOT="6"
if [[ ${PV} != 9999* ]]; then
	KEYWORDS="~amd64"
fi
RDEPEND=">=sonicde-frameworks/sonic-frameworks-windowsystem-6.28:6"
