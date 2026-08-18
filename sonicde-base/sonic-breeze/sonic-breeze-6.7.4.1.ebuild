# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

KFMIN=6.26.0
QTMIN=6.10.1
inherit ecm plasma.sonic xdg

DESCRIPTION="Breeze visual style for the Plasma desktop"

LICENSE="GPL-2" # TODO: CHECK
SLOT="6"
KEYWORDS="~amd64 ~arm64 ~ppc64 ~riscv ~x86"

# sonicde-frameworks/sonic-frameworks-windowsystem[X]: Unconditional use of KX11Extras
DEPEND="
	>=dev-qt/qtbase-${QTMIN}:6[dbus,gui,widgets]
	>=dev-qt/qtdeclarative-${QTMIN}:6
	>=dev-qt/qtsvg-${QTMIN}:6
	>=sonicde-frameworks/sonic-frameworks-qt-integration-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-settings-utils-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-color-scheme-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-settings-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-settings-ui-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-core-addons-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-gui-addons-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-internationalization-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-icon-themes-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-widgets-addons-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-windowsystem-${KFMIN}:6[X]
	>=sonicde-base/sonic-decoration-${KDE_CATV}:6
"
RDEPEND="${DEPEND}
	!<${CATEGORY}/${PN}-6.5.0:5
	sonicde-base/sonic-interface-libraries
	sonicde-base/sonic-silver
"
BDEPEND=">=sonicde-frameworks/sonic-frameworks-settings-utils-${KFMIN}:6"
PDEPEND=">=sonicde-frameworks/sonic-frameworks-silver-icons-${KFMIN}:*"

src_configure() {
	local mycmakeargs=(
		-DBUILD_QT5=OFF
		-DBUILD_QT6=ON
		 # TODO: Consider build options? # bug 911205
		-DWITH_DECORATIONS=ON
		-DWITH_WALLPAPERS=ON
		-DBUILD_CURSOR=ON
		-DBUILD_WITH_QTQUICK=ON # qtdeclarative
	)
	ecm_src_configure
}
