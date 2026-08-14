# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

KDE_ORG_TAR_PN=sonic-login-manager
KFMIN=6.22.0
QTMIN=6.10.0
inherit plasma.sonic pam

DESCRIPTION="PAM configuration for Sonic Login Manager"
HOMEPAGE="https://github.com/Sonic-DE/sonic-login-manager"
# NOTE!  This is the same URI *and* target file name as the
# sonic-login-manager ebuild of the same version.
SRC_URI="${_SONIC_SRC_URI}${KDE_ORG_TAR_PN}/archive/refs/tags/${PV}.tar.gz -> sonic-login-manager-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="6"
KEYWORDS="~amd64"
IUSE="elogind systemd"
REQUIRED_USE="^^ ( elogind systemd )"

DEPEND="
	elogind? ( sys-auth/elogind[pam] )
	systemd? ( sys-apps/systemd[pam] )
"

src_prepare() {
	if use systemd; then
		eapply "${FILESDIR}/${PN}-6.7.3.2-systemd.patch"
	fi

	eapply_user
}

src_configure() {
	# Nothing to configure or compile, this ebuild only installs a
	# config file from the tarball.
	true
}

src_compile() {
	true
}

src_install() {
	# Note: dopamd does some additional logic compared to upstream's
	# INSTALL_PAM_CONFIGURATION=ON behaviour.
	dopamd "${S}"/data/pam/gentoo/soniclogin
	dopamd "${S}"/data/pam/gentoo/soniclogin-autologin
	dopamd "${S}"/data/pam/gentoo/soniclogin-greeter
}
