# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

ECM_NONGUI=true
KFMIN=6.30.0
QTMIN=6.11.2
inherit ecm plasma.sonic

DESCRIPTION="Silver sound theme for SonicDE"

LICENSE="CC-BY-SA-4.0"
SLOT="6"
KEYWORDS="~amd64 ~arm64 ~x86"

RDEPEND+=" !<kde-plasma/ocean-sound-theme-6.8.2 !kde-plasma/ocean-sound-theme:6/6"
PDEPEND+=" ~kde-plasma/ocean-sound-theme-6.8.2:6/6-sonicde"
