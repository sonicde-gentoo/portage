# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="File-free compatibility package for SonicDE system log viewer"
HOMEPAGE="https://github.com/Sonic-DE/sonic-system-log"
LICENSE="metapackage"
SLOT="6/6-sonicde"
IUSE="audit kdesu systemd debug +handbook test"

RESTRICT="!test? ( test )"
RDEPEND="~sonicde-base/sonic-system-log-${PV}:6[audit=,kdesu=,systemd=,debug=,handbook=,test=]"
