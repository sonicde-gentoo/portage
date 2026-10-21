# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

ECM_TEST="true"
KFMIN=6.30.0
QTMIN=6.11.0
inherit ecm plasma.sonic xdg

DESCRIPTION="Components relating to Flatpak pipewire use in Plasma"
LICENSE="LGPL-2.1+"
SLOT="6"
KEYWORDS="~amd64 ~arm64 ~loong ~ppc64 ~riscv ~x86"

RESTRICT="test" # bug 964943

COMMON_DEPEND="
	>=dev-qt/qtbase-${QTMIN}:6=[dbus,gui,opengl]
	>=dev-qt/qtdeclarative-${QTMIN}:6
	>=sonicde-frameworks/sonic-frameworks-core-addons-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-internationalization-${KFMIN}:6
	>=media-libs/libepoxy-1.3
	media-libs/libglvnd
	media-libs/libva:=
	media-libs/mesa[opengl]
	>=media-video/ffmpeg-6.1:=
	>=media-video/pipewire-0.3.33:=
	>=x11-libs/libdrm-2.4.62
"
DEPEND="${COMMON_DEPEND}
"
RDEPEND="${COMMON_DEPEND}
	>=sonicde-frameworks/sonic-frameworks-quick-ui-${KFMIN}:6
"
RDEPEND+=" !<kde-plasma/kpipewire-6.8.0 !kde-plasma/kpipewire:6/6"
PDEPEND+=" ~kde-plasma/kpipewire-6.8.0:6/6-sonicde"
