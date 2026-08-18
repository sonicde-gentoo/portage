# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

ECM_HANDBOOK="forceoptional"
ECM_TEST="forceoptional"
KFMIN=6.26.0
QTMIN=6.10.1
inherit ecm fcaps plasma.sonic

DESCRIPTION="Plugin-based system monitoring daemon"

LICENSE="GPL-2+"
SLOT="6"
IUSE="networkmanager"

DEPEND="
	dev-libs/libnl:3
	>=dev-qt/qtbase-${QTMIN}:6[dbus,network]
	>=sonicde-frameworks/sonic-frameworks-core-addons-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-crash-handler-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-dbus-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-internationalization-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-io-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-device-integration-${KFMIN}:6
	>=sonicde-base/sonic-system-monitor-library-${KDE_CATV}:6
	net-libs/libpcap
	sys-apps/lm-sensors:=
	sys-libs/libcap
	virtual/libudev:=
	networkmanager? ( >=sonicde-frameworks/sonic-frameworks-networkmanager-${KFMIN}:6 )
"
RDEPEND="${DEPEND}"

# -m 0755 to avoid suid with USE="-filecaps"
FILECAPS=( -m 0755 cap_perfmon=ep usr/libexec/ksystemstats_intel_helper )

PATCHES=( "${FILESDIR}/${PN}-6.7.3-optional-nm.patch" ) # in git master

src_configure() {
	local mycmakeargs=(
		-DCMAKE_DISABLE_FIND_PACKAGE_Libcap=ON
		-DWITH_NM=$(usex networkmanager)
	)
	ecm_src_configure
}

CMAKE_SKIP_TESTS=(
	# bug 909312, needs virtualx but we don't care
	ksystemstatstest
)
