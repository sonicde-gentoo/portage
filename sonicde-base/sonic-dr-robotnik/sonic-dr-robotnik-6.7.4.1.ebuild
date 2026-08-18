# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

ECM_TEST="true"
PYTHON_COMPAT=( python3_{12..15} )
KFMIN=6.26.0
QTMIN=6.10.1
inherit ecm plasma.sonic python-single-r1 xdg

DESCRIPTION="Plasma crash handler, gives the user feedback if a program crashed"

LICENSE="GPL-2" # TODO: CHECK
SLOT="6"
KEYWORDS="~amd64 ~arm64 ~ppc64 ~riscv ~x86"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

COMMON_DEPEND="${PYTHON_DEPS}
	>=dev-qt/qtbase-${QTMIN}:6[dbus,gui,network,widgets]
	>=dev-qt/qtdeclarative-${QTMIN}:6
	>=sonicde-frameworks/sonic-frameworks-settings-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-core-addons-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-crash-handler-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-internationalization-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-idle-tracker-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-io-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-progress-ui-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-notifications-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-app-info-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-status-notification-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-keyring-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-widgets-addons-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-windowsystem-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-syntax-highlighting-${KFMIN}:6
	>=sys-apps/systemd-254:=
	>=sys-auth/polkit-qt-0.175.0[qt6(+)]
"
DEPEND="${COMMON_DEPEND}
	>=dev-qt/qtbase-${QTMIN}:6[concurrent]
	test? ( >=dev-qt/qtbase-${QTMIN}:6[network] )
"
RDEPEND="${COMMON_DEPEND}
	|| (
		dev-libs/elfutils[utils]
		>=dev-debug/gdb-18
	)
	>=sonicde-frameworks/sonic-frameworks-quick-ui-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-data-models-${KFMIN}:6
	$(python_gen_cond_dep '
		dev-python/psutil[${PYTHON_USEDEP}]
	')
	|| (
		>=dev-debug/gdb-12
		llvm-core/lldb
	)
	sonicde-base/sonic-polkit
"

src_configure() {
	local mycmakeargs=(
		-DWITH_PYTHON_VENDORING=OFF
	)
	ecm_src_configure
}

src_test() {
	# needs network access, bug #698510
	local myctestargs=(
		-E "(connectiontest)"
	)
	ecm_src_test
}
