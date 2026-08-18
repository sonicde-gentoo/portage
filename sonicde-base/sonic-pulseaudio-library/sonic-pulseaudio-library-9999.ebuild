# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

ECM_HANDBOOK="forceoptional"
ECM_QTHELP="true"
ECM_TEST="true"
KFMIN=6.9.0
QTMIN=6.8.1
inherit ecm sonic

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/Sonic-DE/sonic-pulseaudio-library.git"
else
	SRC_URI="https://github.com/Sonic-DE/sonic-pulseaudio-library/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}/sonic-pulseaudio-library-${PV}"
	KEYWORDS="amd64 arm64 ~loong ~ppc64 ~riscv ~x86"
fi

DESCRIPTION="Qt bindings for libpulse"
HOMEPAGE="https://github.com/Sonic-DE/sonic-pulseaudio-library"

LICENSE="LGPL-2.1"
SLOT="0/5"

RDEPEND="
	>=dev-qt/qtbase-${QTMIN}:6[gui,dbus]
	media-libs/libpulse[glib]
"
DEPEND="${RDEPEND}
	test? ( >=dev-qt/qtdeclarative-${QTMIN}:6 )
"
BDEPEND="virtual/pkgconfig"