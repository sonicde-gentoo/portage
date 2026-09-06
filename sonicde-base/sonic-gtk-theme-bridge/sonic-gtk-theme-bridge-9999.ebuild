# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

KFMIN=6.26.0
QTMIN=6.10.1
inherit ecm plasma.sonic xdg

DESCRIPTION="Syncs KDE Plasma theme settings to GTK applications"

LICENSE="GPL-3"
SLOT="6"

DEPEND="
	dev-libs/glib:2
	>=dev-qt/qtbase-${QTMIN}:6[dbus,gui]
	>=dev-qt/qtsvg-${QTMIN}:6
	gnome-base/gsettings-desktop-schemas
	>=sonicde-frameworks/sonic-frameworks-color-scheme-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-settings-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-core-addons-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-dbus-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-gui-addons-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-windowsystem-${KFMIN}:6
	>=sonicde-base/sonic-decoration-${KDE_CATV}:6
	x11-libs/gtk+:3[X]
"
RDEPEND="${DEPEND}
	x11-misc/xsettingsd
	sonicde-base/sonic-silver-gtk
	sonicde-frameworks/sonic-frameworks-widgets-addons
"
BDEPEND="dev-lang/sassc"

pkg_postinst() {
	xdg_pkg_postinst
	elog "If you notice missing icons in your GTK applications, you may have to install"
	elog "the corresponding themes for GTK. A good guess would be x11-themes/oxygen-gtk"
	elog "for example."
}
