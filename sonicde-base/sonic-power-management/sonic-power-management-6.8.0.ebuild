# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

ECM_HANDBOOK="optional"
ECM_TEST="forceoptional"
KFMIN=6.26.0
QTMIN=6.11.2
inherit ecm fcaps plasma.sonic xdg

DESCRIPTION="Power management for SonicDE"

LICENSE="GPL-2" # TODO: CHECK
SLOT="6"
KEYWORDS="~amd64 ~arm64 ~x86"
IUSE="brightness-control"

RESTRICT="test" # bug 926513

# slot op: Uses Qt::GuiPrivate for qtx11extras_p.h
COMMON_DEPEND="
	dev-libs/qcoro[dbus]
	>=dev-qt/qtbase-${QTMIN}:6=[dbus,gui,widgets]
	>=dev-qt/qtdeclarative-${QTMIN}:6
	>=sonicde-frameworks/sonic-frameworks-auth-${KFMIN}:6[policykit]
	>=sonicde-frameworks/sonic-frameworks-settings-utils-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-settings-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-settings-ui-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-core-addons-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-crash-handler-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-dbus-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-keybind-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-internationalization-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-idle-tracker-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-io-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-quick-ui-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-data-models-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-notifications-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-runner-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-app-info-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-xml-gui-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-windowsystem-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-device-integration-${KFMIN}:6
	>=sonicde-base/sonic-screen-library-${KDE_CATV}:6
	>=sonicde-base/sonic-interface-libraries-${KDE_CATV}:6=
	>=sonicde-base/sonic-activities-${KDE_CATV}:6=
	>=sonicde-base/sonic-workspace-${KDE_CATV}:6
	virtual/libudev:=
	x11-libs/libxcb
	brightness-control? ( app-misc/ddcutil:= )
"
DEPEND="${COMMON_DEPEND}
"
RDEPEND="${COMMON_DEPEND}
	!<sonicde-base/sonic-workspace-6.1.90:*
	|| (
		sys-apps/tuned[ppd]
		sys-power/power-profiles-daemon
		sys-power/tlp
	)
	>=sys-power/upower-0.9.23
"
BDEPEND="
	>=sonicde-frameworks/sonic-frameworks-settings-utils-${KFMIN}:6
	virtual/pkgconfig
"

# -m 0755 to avoid suid with USE="-filecaps"
FILECAPS=( -m 0755 cap_wake_alarm=ep usr/libexec/org_kde_powerdevil )

src_configure() {
	local mycmakeargs=(
		$(cmake_use_find_package brightness-control DDCUtil)
	)
	ecm_src_configure
}

src_test() {
	# bug 926513
	ecm_src_test -j1
}

pkg_postinst() {
	if has_version "<sys-apps/systemd-257"; then
		ewarn "org_kde_powerdevil won't start under systemd user session."
		ewarn "You must upgrade to >=sys-apps/systemd-257. Bug #956312"
	fi
	xdg_pkg_postinst
	fcaps_pkg_postinst
}

RDEPEND+=" !<kde-plasma/powerdevil-6.8.0 !kde-plasma/powerdevil:6/6"
PDEPEND+=" ~kde-plasma/powerdevil-6.8.0:6/6-sonicde"
