# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

KFMIN=6.30.0
QTMIN=6.11.0
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
	>=virtual/zlib-1.2.9:=
	>=sonicde-frameworks/sonic-frameworks-icon-themes-${KFMIN}:6
	>=dev-qt/qtshadertools-${QTMIN}:6
	x11-libs/libXfixes
	x11-libs/libXcursor
	x11-libs/libX11
	sys-libs/libcap
	>=dev-qt/qtbase-${QTMIN}:6=[dbus,gui,network]
	>=dev-qt/qtdeclarative-${QTMIN}:6
	>=sonicde-frameworks/sonic-frameworks-auth-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-settings-utils-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-settings-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-core-addons-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-dbus-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-internationalization-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-io-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-package-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-windowsystem-${KFMIN}:6
	>=sonicde-base/sonic-screen-library-${KDE_CATV}:6
	>=sonicde-base/sonic-interface-libraries-${KDE_CATV}:6=
	>=sonicde-base/sonic-workspace-${KDE_CATV}:6
	sys-libs/pam
	x11-libs/libXau
"
RDEPEND="
	>=dev-qt/qtshadertools-${QTMIN}:6
	x11-libs/libXfixes
	x11-libs/libXcursor
	x11-libs/libX11
	sys-libs/libcap
	>=sonicde-frameworks/sonic-frameworks-app-info-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-quick-silver-style-${KDE_CATV}:6
	${DEPEND}

	acct-user/soniclogin
	sonicde-base/sonic-win[lock]
	s6? ( sys-auth/elogind )
	systemd? ( sys-apps/systemd )
	!s6? ( !systemd? ( sys-auth/elogind ) )
"
DEPEND+=" >=sonicde-base/sonic-keyboard-6.8.1:6"
BDEPEND="
	>=dev-qt/qtshadertools-${QTMIN}:6
	x11-libs/libXfixes
	x11-libs/libXcursor
	x11-libs/libX11
	sys-libs/libcap
	dev-python/docutils
	>=dev-build/cmake-3.25.0
	>=dev-qt/qttools-${QTMIN}:6[linguist]
	sonicde-frameworks/sonic-frameworks-cmake-modules:0
	virtual/pkgconfig
"
RDEPEND+=" !<kde-plasma/plasma-login-manager-6.8.0 !kde-plasma/plasma-login-manager:0/0"
PDEPEND+=" ~kde-plasma/plasma-login-manager-6.8.0:0/0-sonicde"

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
		sed -e "/^find_package/s/ Test QuickTest//" -i CMakeLists.txt || die
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
