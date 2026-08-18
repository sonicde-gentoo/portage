# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

QTMIN=6.10.1
inherit ecm frameworks.sonic

DESCRIPTION="Framework to let applications perform actions as a privileged user"

LICENSE="LGPL-2.1+"
IUSE="+policykit"

RDEPEND="
	>=dev-qt/qtbase-${QTMIN}:6[gui]
	=sonicde-frameworks/sonic-frameworks-core-addons-${KDE_CATV}*:6
	policykit? (
		>=dev-qt/qtbase-${QTMIN}:6[dbus]
		=sonicde-frameworks/sonic-frameworks-windowsystem-${KDE_CATV}*:6
		>=sys-auth/polkit-qt-0.175.0[qt6(+)]
	)
"
DEPEND="${RDEPEND}
	test? ( >=dev-qt/qtbase-${QTMIN}:6[dbus] )
"
BDEPEND=">=dev-qt/qttools-${QTMIN}:6[linguist]"
PDEPEND="policykit? ( sonicde-base/sonic-polkit-agent:* )"

CMAKE_SKIP_TESTS=(
	# fails, bug 654842
	KAuthHelperTest
	# needs DBus, bug 938505
	KAuthFdTest
)

src_configure() {
	local mycmakeargs=(
		$(cmake_use_find_package policykit PolkitQt6-1)
	)

	ecm_src_configure
}
