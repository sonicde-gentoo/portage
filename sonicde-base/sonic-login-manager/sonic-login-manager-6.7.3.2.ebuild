# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

KFMIN=6.22.0
QTMIN=6.10.0
inherit ecm plasma.sonic linux-info pam

DESCRIPTION="Sonic Login Manager"
HOMEPAGE="https://github.com/Sonic-DE/sonic-login-manager"

LICENSE="GPL-2+ MIT CC-BY-3.0 CC-BY-SA-3.0 public-domain"
SLOT="6"
KEYWORDS="~amd64"
IUSE="test"
RESTRICT="!test? ( test )"

DEPEND="
	>=dev-qt/qtbase-${QTMIN}:6[dbus,gui,network]
	>=dev-qt/qtdeclarative-${QTMIN}:6
	>=kde-frameworks/kauth-${KFMIN}:6
	>=kde-frameworks/kcmutils-${KFMIN}:6
	>=kde-frameworks/kconfig-${KFMIN}:6
	>=kde-frameworks/kcoreaddons-${KFMIN}:6
	>=kde-frameworks/kdbusaddons-${KFMIN}:6
	>=kde-frameworks/ki18n-${KFMIN}:6
	>=kde-frameworks/kio-6.22.1:6
	>=kde-frameworks/kpackage-${KFMIN}:6
	>=kde-frameworks/kwindowsystem-${KFMIN}:6
	>=kde-plasma/kscreen-${KDE_CATV}:6
	>=kde-plasma/libplasma-${KDE_CATV}:6=
	>=sonicde-base/sonic-workspace-${KDE_CATV}:6
	sys-libs/pam
	x11-libs/libXau
"
RDEPEND="
	${DEPEND}
	!kde-plasma/plasma-login-manager
	acct-user/soniclogin
	=sonicde-base/sonic-login-manager-pam-${PV}*
	sonicde-base/sonic-win[lock]
	|| ( sys-auth/elogind sys-apps/systemd )
"
BDEPEND="
	dev-python/docutils
	>=dev-build/cmake-3.25.0
	>=dev-qt/qttools-${QTMIN}[linguist]
	kde-frameworks/extra-cmake-modules:0
	virtual/pkgconfig
"

pkg_setup() {
	local CONFIG_CHECK="~DRM"
	use kernel_linux && linux-info_pkg_setup
}

src_prepare() {
	touch 01gentoo.conf || die

	cat <<-EOF >> 01gentoo.conf
	[General]
	# Remove qtvirtualkeyboard as InputMethod default
	InputMethod=
	EOF

	cmake_src_prepare

	if ! use test; then
		sed -e "/^find_package/s/ Test//" -i CMakeLists.txt || die
		cmake_comment_add_subdirectory test
	fi
}

src_configure() {
	local mycmakeargs=(
		-DRUNTIME_DIR=/run/soniclogin

		# PAM config is installed by sonic-login-manager-pam.ebuild.
		-DINSTALL_PAM_CONFIGURATION=OFF
		# If non-systemd compat ever arrives, we can try 7
		# again to be in sync with CHECKVT from display-manager,
		# but until then, stick with upstream default of 1.
		#-DSONICLOGIN_INITIAL_VT=7

		# lightdm also installs an org.freedesktop.DisplayManager.conf,
		# see: https://bugs.gentoo.org/980039
		-DDBUS_CONFIG_FILENAME=sonicde-org.freedesktop.DisplayManager.conf
	)

	cmake_src_configure
}

src_install() {
	cmake_src_install

	insinto /etc/soniclogin.conf.d/
	doins "${S}"/01gentoo.conf
}

# Sonic: pkg_postinst call to 'tmpfiles_process soniclogin.conf' dropped,
# sonic-login-manager doesn't use tmpfiles.
