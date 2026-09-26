# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# TODO: ECMGenerateQDoc
ECM_TEST=true
KFMIN=6.13.0
QTMIN=6.8.1
inherit ecm sonic

DESCRIPTION="QtQuick components providing basic image editing capabilities"
HOMEPAGE="https://github.com/Sonic-DE/sonic-quick-image-editor"
SRC_URI="https://github.com/Sonic-DE/sonic-quick-image-editor/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/sonic-quick-image-editor-${PV}"
LICENSE="LGPL-2.1+"
SLOT="6"
KEYWORDS="~amd64 ~arm64 ~loong ~ppc64 ~riscv ~x86"

IUSE="+opencv"

DEPEND="
	>=dev-qt/qtbase-${QTMIN}:6[gui]
	>=dev-qt/qtdeclarative-${QTMIN}:6
	>=sonicde-frameworks/sonic-frameworks-settings-${KFMIN}:6
	opencv? ( media-libs/opencv:= )
"
RDEPEND="${DEPEND}

	!${CATEGORY}/${PN}:5
	>=sonicde-frameworks/sonic-frameworks-quick-ui-${KFMIN}:6
"
RDEPEND+=" !<media-libs/kquickimageeditor-0.7.0.1 !media-libs/kquickimageeditor:6/6"
PDEPEND+=" ~media-libs/kquickimageeditor-0.7.0.1:6/6-sonicde"

src_configure() {
	local mycmakeargs=(
		-DWITH_OPENCV=$(usex opencv)
	)
	ecm_src_configure
}
