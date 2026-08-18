# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

ECM_HANDBOOK="optional"
ECM_TEST="true"
PVCUT=$(ver_cut 1-3)
KFMIN=6.23.0
QTMIN=6.10.1
inherit ecm xdg

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/Sonic-DE/sonic-ecco.git"
else
	SRC_URI="https://github.com/Sonic-DE/sonic-ecco/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}/sonic-ecco-${PV}"
	KEYWORDS="~amd64 ~arm64 ~x86"
fi

DESCRIPTION="Sonic DE file manager focusing on usability"
HOMEPAGE="https://github.com/Sonic-DE/sonic-ecco"

LICENSE="GPL-2"
SLOT="6"
IUSE="semantic-desktop telemetry"

# slot op: Uses Qt::GuiPrivate for qtx11extras_p.h
DEPEND="
	>=dev-qt/qtbase-${QTMIN}:6=[concurrent,dbus,gui,widgets,X,xml]
	>=dev-qt/qtmultimedia-${QTMIN}:6
	>=sonicde-frameworks/sonic-frameworks-bookmarks-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-settings-ui-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-text-codec-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-color-scheme-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-autocomplete-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-config-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-config-widgets-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-core-addons-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-crash-handler-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-dbus-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-file-metadata-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-gui-addons-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-internationalization-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-icon-themes-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-io-${KFMIN}:6=
	>=sonicde-frameworks/sonic-frameworks-item-views-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-job-widgets-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-new-stuff-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-notifications-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-parts-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-service-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-text-widgets-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-widgets-addons-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-windowsystem-${KFMIN}:6[X]
	>=sonicde-frameworks/sonic-frameworks-xml-gui-${KFMIN}:6
	>=sonicde-frameworks/sonic-frameworks-solid-${KFMIN}:6
	semantic-desktop? (
		>=sonicde-base/sonic-frameworks-baloo-widgets-${PVCUT}:6
		>=sonicde-frameworks/sonic-frameworks-baloo-${KFMIN}:6
	)
	telemetry? ( >=sonicde-frameworks/sonic-frameworks-user-feedback-${KFMIN}:6 )
"
RDEPEND="${DEPEND}
	>=sonicde-base/sonic-frameworks-io-extras-${PVCUT}:6
	>=sonicde-base/sonic-frameworks-thumbnailers-${PVCUT}:6
"

CMAKE_SKIP_TESTS=(
	servicemenuinstaller
	dolphinmainwindowtest
	kfileitem{listview,model}test
	kitemlistcontrollertest
	kitemlistcontrollerexpandtest
	placesitemmodeltest
)

src_configure() {
	local mycmakeargs=(
		-DCMAKE_DISABLE_FIND_PACKAGE_PackageKitQt6=ON
		$(cmake_use_find_package semantic-desktop KF6Baloo)
		$(cmake_use_find_package semantic-desktop KF6BalooWidgets)
		$(cmake_use_find_package telemetry KF6UserFeedback)
	)
	use test && mycmakeargs+=(
		-DCMAKE_DISABLE_FIND_PACKAGE_SeleniumWebDriverATSPI=ON
	)
	ecm_src_configure
}

pkg_postinst() {
	xdg_pkg_postinst
}
