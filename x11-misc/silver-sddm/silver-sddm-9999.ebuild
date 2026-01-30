# Copyright 1999-2026 Soccera
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3

DESCRIPTION="Sonic Silver is an SDDM theme fork based on the AndromiX-SDDM-Theme project by Ziednaga, with fixes."
HOMEPAGE="https://github.com/Sonic-DE/silver-sddm"

EGIT_REPO_URI="https://github.com/Sonic-DE/silver-sddm.git"
LICENSE="GPL-2+"
SLOT="0"
if [[ ${PV} != 9999* ]]; then
	KEYWORDS="~amd64"
fi
IUSE=""
RDEPEND="x11-misc/sddm"

src_install() {
	insinto /usr/share/sddm/themes/
	doins -r Sonic-Silver Sonic-Silver-Light
}
