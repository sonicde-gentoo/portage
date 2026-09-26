# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

ECM_PYTHON_BINDINGS="off"
QTMIN=6.10.1
inherit ecm frameworks.sonic xdg

DESCRIPTION="Framework providing assorted high-level user interface components"
LICENSE="LGPL-2+"
KEYWORDS="~amd64 ~arm64 ~loong ~ppc64 ~riscv ~x86"
IUSE="dbus"

# slot op: includes qpa/qplatformnativeinterface.h, private/qguiapplication_p.h
COMMON_DEPEND="
	>=dev-qt/qtbase-${QTMIN}:6[gui]
	>=dev-qt/qtdeclarative-${QTMIN}:6
	dbus? ( >=dev-qt/qtbase-${QTMIN}:6=[dbus] )
	>=dev-qt/qtbase-${QTMIN}:6
	x11-libs/libX11
"
DEPEND="${COMMON_DEPEND}
	x11-base/xorg-proto
	x11-libs/libxcb
"
RDEPEND="${COMMON_DEPEND}"
RDEPEND+=" !<kde-frameworks/kguiaddons-6.30.0 !kde-frameworks/kguiaddons:6/6.30"
PDEPEND+=" ~kde-frameworks/kguiaddons-6.30.0:6/6.30-sonicde"

src_configure() {
	local mycmakeargs=(
		-DBUILD_GEO_SCHEME_HANDLER=ON
		-DUSE_DBUS=$(usex dbus)
	)
	ecm_src_configure
}
