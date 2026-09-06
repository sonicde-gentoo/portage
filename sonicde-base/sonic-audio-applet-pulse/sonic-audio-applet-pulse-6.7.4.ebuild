# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

ECM_HANDBOOK="optional"
ECM_TEST="forceoptional"
KFMIN=6.26.0
QTMIN=6.10.1
inherit ecm plasma.sonic xdg

DESCRIPTION="Plasma applet for audio volume management using PulseAudio"

LICENSE="GPL-2" # TODO: CHECK
SLOT="6"
KEYWORDS="~amd64 ~arm64 ~ppc64 ~riscv ~x86"

RESTRICT="test" # missing selenium-webdriver-at-spi

DEPEND="
	dev-libs/glib:2
	>=dev-qt/qtbase-${QTMIN}:6[dbus,gui,widgets]
	>=dev-qt/qtdeclarative-${QTMIN}:6
	>=sonicde-frameworks/sonic-frameworks-settings-utils-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-settings-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-core-addons-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-dbus-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-qml-bridge-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-keybind-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-internationalization-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-status-notification-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-svg-${KFMIN}:6
	>=sonicde-base/sonic-interface-libraries-${KDE_CATV}:6=
	media-libs/libcanberra
	media-libs/libpulse
	>=sonicde-base/sonic-pulseaudio-library-1.6.0:=
"
RDEPEND="${DEPEND}
	sonicde-frameworks/sonic-frameworks-quick-ui-addons:6
	>=sonicde-frameworks/sonic-frameworks-quick-ui-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-data-models-${KFMIN}:6
	x11-themes/sound-theme-freedesktop
"
BDEPEND=">=sonicde-frameworks/sonic-frameworks-settings-utils-${KFMIN}:6"
