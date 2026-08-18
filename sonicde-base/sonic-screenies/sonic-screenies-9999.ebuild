# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

ECM_HANDBOOK="optional"
ECM_TEST="forceoptional"
KFMIN=6.26.0
QTMIN=6.10.1
inherit ecm plasma.sonic xdg

DESCRIPTION="Screenshot capture utility"
HOMEPAGE="https://apps.kde.org/spectacle/"

LICENSE="LGPL-2+ handbook? ( FDL-1.3 )"
SLOT="6"
IUSE="share"

# slot op: Uses Qt::GuiPrivate for qtx11extras_p.h
COMMON_DEPEND="
	app-text/tesseract:=
	>=dev-qt/qtbase-${QTMIN}:6=[concurrent,dbus,gui,widgets,X]
	>=dev-qt/qtdeclarative-${QTMIN}:6
	>=dev-qt/qtmultimedia-${QTMIN}:6[qml]
	>=sonicde-frameworks/sonic-frameworks-settings-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-settings-ui-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-core-addons-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-crash-handler-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-dbus-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-keybind-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-gui-addons-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-internationalization-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-io-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-quick-ui-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-notifications-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-app-info-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-status-notification-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-widgets-addons-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-windowsystem-${KFMIN}:6[X]
	>=sonicde-frameworks/sonic-frameworks-xml-gui-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-barcode-${KFMIN}:6
	>=sonicde-base/sonic-pipewire-${KDE_CATV}:6
	>=sonicde-base/sonic-quick-image-editor-0.6.0:6
	media-libs/opencv:=
	x11-libs/libxcb
	x11-libs/libXrandr
	x11-libs/xcb-util
	x11-libs/xcb-util-cursor
	x11-libs/xcb-util-image
	share? ( >=sonicde-frameworks/sonic-frameworks-purpose-${KFMIN}:6 )
"
DEPEND="${COMMON_DEPEND}
"
RDEPEND="${COMMON_DEPEND}
	>=dev-qt/qtimageformats-${QTMIN}:6
	>=dev-qt/qtsvg-${QTMIN}:6
	>=sonicde-frameworks/sonic-frameworks-image-formats-${KFMIN}:6
"
BDEPEND="
	>=dev-qt/qtbase-${QTMIN}:6
	virtual/pkgconfig
"

src_configure() {
	local mycmakeargs=(
		$(cmake_use_find_package share KF6Purpose)
	)
	ecm_src_configure
}
