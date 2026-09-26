# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

KFMIN=6.22.0
QTMIN=6.10.0
inherit ecm plasma.sonic linux-info systemd

DESCRIPTION="Sonic Login Manager"
HOMEPAGE="https://github.com/Sonic-DE/sonic-login-manager"

LICENSE="GPL-2+ MIT CC-BY-3.0 CC-BY-SA-3.0 public-domain"
SLOT="6"
KEYWORDS="~amd64"
IUSE="s6 systemd test"
REQUIRED_USE="?? ( s6 systemd )"
RESTRICT="!test? ( test )"

DEPEND="
	>=dev-qt/qtbase-${QTMIN}:6[dbus,gui,network]
	>=dev-qt/qtdeclarative-${QTMIN}:6
	>=sonicde-frameworks/sonic-frameworks-auth-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-settings-utils-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-settings-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-core-addons-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-dbus-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-internationalization-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-io-6.22.1:6
	>=sonicde-frameworks/sonic-frameworks-package-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-windowsystem-${KFMIN}:6
	>=sonicde-base/sonic-screen-${KDE_CATV}:6
	>=sonicde-base/sonic-interface-libraries-${KDE_CATV}:6=
	>=sonicde-base/sonic-workspace-${KDE_CATV}:6
	sys-libs/pam
	x11-libs/libXau
"
RDEPEND="
	${DEPEND}

	acct-user/soniclogin
	sonicde-base/sonic-win[lock]
	s6? ( sys-auth/elogind )
	systemd? ( sys-apps/systemd )
	!s6? ( !systemd? ( sys-auth/elogind ) )
"
BDEPEND="
	dev-python/docutils
	>=dev-build/cmake-3.25.0
	>=dev-qt/qttools-${QTMIN}[linguist]
	sonicde-frameworks/sonic-frameworks-cmake-modules:0
	virtual/pkgconfig
"
RDEPEND+=" !<kde-plasma/plasma-login-manager-6.7.3 !kde-plasma/plasma-login-manager:0/0"
PDEPEND+=" ~kde-plasma/plasma-login-manager-6.7.3:0/0-sonicde"

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

		# If non-systemd compat ever arrives, we can try 7
		# again to be in sync with CHECKVT from display-manager,
		# but until then, stick with upstream default of 1.
		#-DSONICLOGIN_INITIAL_VT=7

		# lightdm also installs an org.freedesktop.DisplayManager.conf,
		# see: https://bugs.gentoo.org/980039
		-DDBUS_CONFIG_FILENAME=sonicde-org.freedesktop.DisplayManager.conf

		# Install init units selected by USE flags.
		-DMANUAL_INITS=ON
		-DOPENRC_FOUND:BOOL=$(usex s6 OFF "$(usex systemd OFF ON)")
		-DS6_FOUND:BOOL=$(usex s6 ON OFF)
		-DSYSTEMD_FOUND:BOOL=$(usex systemd ON OFF)
		-DKDE_INSTALL_SYSTEMDUNITDIR="$(systemd_get_systemunitdir)"
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
