# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

ECM_HANDBOOK="optional"
ECM_TEST="forceoptional"
KFMIN=6.22.0
QTMIN=6.10.1
inherit ecm sonic

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/Sonic-DE/sonic-system-log.git"
else
	SRC_URI="https://github.com/Sonic-DE/sonic-system-log/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}/sonic-system-log-${PV}"
fi

DESCRIPTION="System log viewer by KDE"
HOMEPAGE="https://github.com/Sonic-DE/sonic-system-log"

LICENSE="GPL-2" # TODO: CHECK
SLOT="6"
IUSE="audit kdesu systemd"

DEPEND="
	>=dev-qt/qtbase-${QTMIN}:6[gui,widgets]
	>=sonicde-frameworks/sonic-frameworks-archive-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-autocomplete-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-settings-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-settings-ui-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-core-addons-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-crash-handler-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-internationalization-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-io-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-data-views-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-text-widgets-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-widgets-addons-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-xml-gui-${KFMIN}:6
	audit? ( sys-process/audit )
	systemd? (
		>=dev-qt/qtbase-${QTMIN}:6[network]
		sys-apps/systemd:=
	)
"
RDEPEND="${DEPEND}
	sonicde-frameworks/sonic-frameworks-doctools
"

src_prepare() {
	ecm_src_prepare
	if ! use kdesu; then
		sed -e "/^X-KDE-SubstituteUID/s:true:false:" \
			-i src/org.kde.ksystemlog.desktop || die
	fi
}

src_configure() {
	local mycmakeargs=(
		$(cmake_use_find_package audit Audit)
		$(cmake_use_find_package systemd Journald)
	)
	ecm_src_configure
}

pkg_postinst() {
	use kdesu || elog "Will show only user readable logs without USE=kdesu (only in X)."
	use kdesu && elog "Cannot be launched from application menu in Wayland with USE=kdesu."
}