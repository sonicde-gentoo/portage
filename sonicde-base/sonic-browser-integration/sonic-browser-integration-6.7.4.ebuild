# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

KFMIN=6.26.0
QTMIN=6.10.1
inherit ecm plasma.sonic xdg

DESCRIPTION="Integrate Chrome/Firefox better into Plasma through browser extensions"
HOMEPAGE+=" https://community.kde.org/Plasma/Browser_Integration"

LICENSE="GPL-3+"
SLOT="6"
KEYWORDS="~amd64 ~arm64 ~ppc64 ~riscv ~x86"

RDEPEND="
	>=dev-qt/qtbase-${QTMIN}:6[dbus,gui,widgets]
	>=sonicde-frameworks/sonic-frameworks-settings-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-core-addons-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-crash-handler-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-dbus-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-file-metadata-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-internationalization-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-io-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-progress-ui-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-notifications-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-app-info-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-status-notification-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-purpose-${KFMIN}:6
	>=sonicde-base/sonic-activities-${KDE_CATV}:6=
	>=sonicde-base/sonic-workspace-${KDE_CATV}:6
"
DEPEND="${RDEPEND}
	>=sonicde-frameworks/sonic-frameworks-runner-${KFMIN}:6
"

src_configure() {
	local mycmakeargs=(
		-DMOZILLA_DIR="${EPREFIX}/usr/$(get_libdir)/mozilla"
	)

	ecm_src_configure
}
