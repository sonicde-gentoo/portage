# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

ECM_EXAMPLES="true"
ECM_TEST="true"
KFMIN=6.26.0
QTMIN=6.10.1
inherit ecm flag-o-matic plasma.sonic toolchain-funcs xdg

DESCRIPTION="Library and examples for creating an RDP server"
HOMEPAGE+=" https://quantumproductions.info/articles/2023-08/remote-desktop-using-rdp-protocol-plasma-wayland"

LICENSE="GPL-2" # TODO: CHECK
SLOT="6"
IUSE="systemd"

COMMON_DEPEND="
	>=dev-libs/qtkeychain-0.14.2:=[qt6(+)]
	>=dev-qt/qtbase-${QTMIN}:6[dbus,gui,network]
	>=dev-qt/qtdeclarative-${QTMIN}:6
	>=sonicde-frameworks/sonic-frameworks-settings-utils-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-settings-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-core-addons-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-crash-handler-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-dbus-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-gui-addons-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-internationalization-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-status-notification-${KFMIN}:6
	>=sonicde-base/sonic-pipewire-${KDE_CATV}:6
	>=net-misc/freerdp-3.1:3[server]
	sys-libs/pam
	x11-libs/libxkbcommon
	systemd? ( >=sys-apps/systemd-254:= )
"
DEPEND="${COMMON_DEPEND}
"
RDEPEND="${COMMON_DEPEND}
	sonicde-frameworks/sonic-frameworks-quick-ui-addons:6
	>=sonicde-frameworks/sonic-frameworks-quick-ui-${KFMIN}:6
"
BDEPEND=">=sonicde-frameworks/sonic-frameworks-settings-utils-${KFMIN}:6"

src_configure() {
	# std::jthread and std::stop_token are implemented as experimental in libcxx
	# enable these experimental libraries on clang systems
	# https://libcxx.llvm.org/Status/Cxx20.html#note-p0660
	[[ $(tc-get-cxx-stdlib) == 'libc++' ]] && append-cxxflags -fexperimental-library

	local mycmakeargs=(
		$(cmake_use_find_package systemd Systemd)
	)

	ecm_src_configure
}
