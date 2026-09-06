# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

KFMIN=6.26.0
QTMIN=6.10.1
inherit ecm sonic git-r3

EGIT_REPO_URI="https://github.com/Sonic-DE/sonic-breeze-sddm.git"

DESCRIPTION="Sonic Breeze SDDM theme"
HOMEPAGE="https://github.com/Sonic-DE/sonic-breeze-sddm"

LICENSE="GPL-2+"
SLOT="0"

DEPEND="
	>=dev-qt/qtbase-${QTMIN}:6[gui]
	>=dev-qt/qtdeclarative-${QTMIN}:6
	>=dev-qt/qt5compat-${QTMIN}:6
	>=sonicde-frameworks/sonic-frameworks-cmake-modules-${KFMIN}:*
	>=sonicde-base/sonic-breeze-${KDE_CATV}:6
"
RDEPEND="${DEPEND}
	|| (
		>=x11-misc/sddm-0.21.0[qt6]
		>=gui-libs/display-manager-init
	)
"

src_configure() {
	local mycmakeargs=(
		-DINSTALL_QMLDIR=${KDE_INSTALL_QMLDIR}
	)
	ecm_src_configure
}
