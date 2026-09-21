# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

ECM_TEST="true"
KFMIN=6.26.0
QTMIN=6.10.1
inherit ecm plasma.sonic xdg

DESCRIPTION="Components relating to Flatpak pipewire use in Plasma"

LICENSE="LGPL-2.1+"
SLOT="6"
KEYWORDS="~amd64 ~arm64 ~ppc64 ~riscv ~x86"

RESTRICT="test" # bug 964943

COMMON_DEPEND="
	>=dev-qt/qtbase-${QTMIN}:6[dbus,gui,opengl]
	>=dev-qt/qtdeclarative-${QTMIN}:6
	>=sonicde-frameworks/sonic-frameworks-core-addons-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-internationalization-${KFMIN}:6
	media-libs/libepoxy
	media-libs/libglvnd
	media-libs/libva:=
	media-libs/mesa[opengl]
	>=media-video/ffmpeg-6.1:=
	>=media-video/pipewire-0.3:=
	x11-libs/libdrm
"
DEPEND="${COMMON_DEPEND}
	test? (
		>=dev-qt/qtbase-${QTMIN}:6
		media-video/pipewire[extra]
	)
"
RDEPEND="${COMMON_DEPEND}
	>=sonicde-frameworks/sonic-frameworks-quick-ui-${KFMIN}:6
	sonicde-base/xdg-desktop-portal-sonicde
"
BDEPEND="test? ( >=dev-qt/qtbase-${QTMIN}:6 )"
