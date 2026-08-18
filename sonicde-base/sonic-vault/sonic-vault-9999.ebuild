# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

KFMIN=6.26.0
QTMIN=6.10.1
inherit ecm flag-o-matic plasma.sonic xdg

DESCRIPTION="Plasma applet and services for creating encrypted vaults"
HOMEPAGE+=" https://cukic.co/2017/02/03/vaults-encryption-in-plasma/"

LICENSE="LGPL-3"
SLOT="6"
IUSE="networkmanager"

DEPEND="
	>=dev-qt/qtbase-${QTMIN}:6[dbus,gui,widgets]
	>=dev-qt/qtdeclarative-${QTMIN}:6
	>=sonicde-frameworks/sonic-frameworks-text-codec-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-settings-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-core-addons-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-dbus-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-internationalization-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-io-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-data-models-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-app-info-${KFMIN}:6
	>=sonicde-base/sonic-system-monitor-library-${KDE_CATV}:6
	>=sonicde-base/sonic-interface-libraries-${KDE_CATV}:6=
	>=sonicde-base/sonic-activities-${KDE_CATV}:6=
	networkmanager? ( >=sonicde-frameworks/sonic-frameworks-networkmanager-${KFMIN}:6 )
"
RDEPEND="${DEPEND}
	>=app-crypt/gocryptfs-1.8
	sonicde-frameworks/sonic-frameworks-auth
	sonicde-frameworks/sonic-frameworks-autocomplete
	sonicde-frameworks/sonic-frameworks-device-integration
	sonicde-frameworks/sonic-frameworks-package
	sonicde-frameworks/sonic-frameworks-progress-ui
	sonicde-frameworks/sonic-frameworks-settings-ui
	sonicde-frameworks/sonic-frameworks-widgets-addons
	sonicde-frameworks/sonic-frameworks-windowsystem
"

pkg_pretend() {
	if [[ -n "${REPLACING_VERSIONS}" ]] && ! has_version app-crypt/gocryptfs; then
		ewarn "${CATEGORY}/${PN} now depends on app-crypt/gocryptfs exclusively."
		ewarn "If you still use deprecated CryFS or EncFS, you must put them in @world."
	fi
}

src_configure() {
	# ODR violations (bug #909446, kde#471836)
	filter-lto

	local mycmakeargs=(
		$(cmake_use_find_package networkmanager KF6NetworkManagerQt)
	)

	ecm_src_configure
}

pkg_postinst() {
	xdg_pkg_postinst

	local has_deprecated_backend
	dropping_backend() {
		if has_version ${2}; then
			elog "${CATEGORY}/${PN} will drop support for ${1} in the future."
			elog "Migrate away from any ${2} vaults before that happens."
			elog
			has_deprecated_backend=1
		fi
	}

	dropping_backend CryFS sys-fs/cryfs
	dropping_backend EncFS sys-fs/encfs

	if [[ has_deprecated_backend ]]; then
		elog "The only supported backend going forward will be app-crypt/gocryptfs."
		elog
		elog "See also:"
		elog "https://invent.kde.org/plasma/plasma-vault/-/merge_requests/57"
		elog "https://invent.kde.org/plasma/plasma-vault/-/merge_requests/62"
	fi
}
