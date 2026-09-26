# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

inherit toolchain-funcs

# Sonic: Mimicing KDE_CATV from plasma.sonic.eclass.
BASE_MIN=$(ver_cut 1-3)
[[ ${PV} == *9999* ]] && BASE_MIN=6.7
FRAMEWORKS_MIN=6.29.0

DESCRIPTION="Merge this to pull in all Sonic DE packages"
HOMEPAGE="https://github.com/Sonic-DE"

LICENSE="metapackage"
SLOT="6"
if [[ "${PV}" != *9999 ]]; then
	KEYWORDS="~amd64 ~arm64 ~x86"
fi
IUSE="accessibility bluetooth +browser-integration +crash-handler crypt cups +display-manager +elogind +file-manager +firewall gtk +kwallet +networkmanager ocr oxygen-theme plymouth pulseaudio rdp sdk +smart systemd thunderbolt unsupported virtualkeyboard wacom +wallpapers webengine"

RDEPEND="
	dev-perl/XML-Parser
	!${CATEGORY}/${PN}:5
	!kde-plasma/khotkeys:5
	>=sonicde-base/sonic-activity-manager-daemon-${BASE_MIN}:${SLOT}
	>=sonicde-base/sonic-terminal-tools-${BASE_MIN}:${SLOT}
	>=sonicde-base/sonic-decoration-${BASE_MIN}:${SLOT}
	>=sonicde-base/sonic-workspace-addons-${BASE_MIN}:${SLOT}
	>=sonicde-frameworks/sonic-frameworks-root-shell-${FRAMEWORKS_MIN}
	>=sonicde-base/sonic-desktop-interface-${BASE_MIN}
	>=sonicde-base/sonic-keybind-daemon-${BASE_MIN}:${SLOT}
	>=sonicde-base/sonic-system-info-${BASE_MIN}:${SLOT}
	>=kde-plasma/systemsettings-${BASE_MIN}:${SLOT}
	>=sonicde-base/sonic-launcher-menu-edit-${BASE_MIN}:${SLOT}
	>=sonicde-base/sonic-night-light-${BASE_MIN}:${SLOT}
	>=sonicde-base/sonic-pipewire-${BASE_MIN}:${SLOT}
	>=sonicde-base/sonic-screen-${BASE_MIN}:${SLOT}
	>=sonicde-base/sonic-screenlocker-${BASE_MIN}:${SLOT}
	>=sonicde-base/sonic-silver-${BASE_MIN}:${SLOT}
	>=sonicde-base/sonic-silver-icons-${FRAMEWORKS_MIN}:${SLOT}
	>=sonicde-base/sonic-ssh-password-prompt-${BASE_MIN}:${SLOT}
	>=sonicde-base/sonic-system-stats-${BASE_MIN}:${SLOT}
	>=sonicde-base/sonic-write-daemon-${BASE_MIN}:${SLOT}
	>=sonicde-base/sonic-screen-library-${BASE_MIN}:${SLOT}
	>=sonicde-base/sonic-system-monitor-library-${BASE_MIN}:${SLOT}
	>=sonicde-base/sonic-interface-libraries-${BASE_MIN}:${SLOT}
	>=sonicde-base/sonic-file-search-ui-${BASE_MIN}:${SLOT}
	>=kde-plasma/ocean-sound-theme-${BASE_MIN}:${SLOT}
	>=sonicde-base/sonic-activities-${BASE_MIN}:${SLOT}
	>=sonicde-base/sonic-activities-stats-${BASE_MIN}:${SLOT}
	>=sonicde-base/sonic-qt-theme-bridge-${BASE_MIN}:${SLOT}
	>=sonicde-base/sonic-system-monitor-${BASE_MIN}:${SLOT}
	>=sonicde-base/sonic-welcome-center-${BASE_MIN}:${SLOT}
	>=sonicde-base/sonic-plasma5-support-library-${BASE_MIN}:${SLOT}
	>=sonicde-base/sonic-polkit-agent-${BASE_MIN}:*
	>=kde-plasma/powerdevil-${BASE_MIN}:${SLOT}
	>=sonicde-frameworks/sonic-frameworks-quick-silver-style-${BASE_MIN}:${SLOT}
	>=sonicde-base/sonic-desktop-interface-${BASE_MIN}:${SLOT}
	>=sonicde-base/sonic-win-${BASE_MIN}:${SLOT}[lock]
	>=sonicde-base/sonic-workspace-${BASE_MIN}:${SLOT}
	>=sonicde-base/xdg-desktop-portal-sonicde-${BASE_MIN}:${SLOT}
	sys-apps/dbus[elogind?,systemd?]
	sys-auth/polkit[systemd?]
	sys-fs/udisks:2[elogind?,systemd?]
	bluetooth? ( >=sonicde-base/sonic-bluetooth-runtime-${BASE_MIN}:${SLOT} )
	browser-integration? ( >=sonicde-base/sonic-browser-integration-${BASE_MIN}:${SLOT} )
	crash-handler? ( >=sonicde-base/sonic-dr-robotnik-${BASE_MIN}:${SLOT} )
	crypt? ( >=sonicde-base/sonic-vault-${BASE_MIN}:${SLOT} )
	cups? (
		>=kde-plasma/print-manager-${BASE_MIN}:${SLOT}
		net-print/cups-meta
	)
	display-manager? ( >=sonicde-base/sonic-login-manager-${BASE_MIN}:${SLOT}[systemd=] )
	elogind? ( sys-auth/elogind[pam] )
	file-manager? ( >=sonicde-base/sonic-ecco-26.04.3.2:${SLOT} )
	gtk? (
		>=sonicde-base/sonic-silver-gtk-${BASE_MIN}:${SLOT}
		>=sonicde-base/sonic-gtk-theme-bridge-${BASE_MIN}:${SLOT}
		sys-apps/xdg-desktop-portal-gtk
		x11-misc/appmenu-gtk-module
	)
	kwallet? ( >=sonicde-frameworks/sonic-frameworks-keyring-pam-${BASE_MIN}:${SLOT} )
	networkmanager? (
		>=sonicde-base/sonic-network-manager-${BASE_MIN}:${SLOT}
		net-misc/networkmanager[elogind?,systemd?]
	)
	oxygen-theme? (
		>=sonicde-base/sonic-oxygen-icons-6.0.0:*
	>=sonicde-base/sonic-oxygen-${BASE_MIN}:${SLOT}
		>=sonicde-base/sonic-oxygen-sounds-${BASE_MIN}:${SLOT}
	)
	plymouth? (
		>=kde-plasma/plymouth-kcm-${BASE_MIN}:${SLOT}
	)
	pulseaudio? ( >=sonicde-base/sonic-audio-applet-pulse-${BASE_MIN}:${SLOT} )
	rdp? ( >=sonicde-base/sonic-rdp-server-${BASE_MIN}:${SLOT} )
	sdk? ( >=kde-plasma/plasma-sdk-${BASE_MIN}:${SLOT} )
	smart? ( >=sonicde-base/sonic-disks-${BASE_MIN}:${SLOT} )
	systemd? (
		>=sys-apps/systemd-257[pam]
		firewall? ( >=sonicde-base/sonic-firewall-${BASE_MIN}:${SLOT} )
	)
	thunderbolt? (
		amd64? ( >=sonicde-base/sonic-thunderbolt-${BASE_MIN}:${SLOT} )
		x86? ( >=sonicde-base/sonic-thunderbolt-${BASE_MIN}:${SLOT} )
	)
	!unsupported? ( !gui-apps/qt6ct )
	virtualkeyboard? ( >=kde-plasma/plasma-keyboard-${BASE_MIN}:${SLOT} )
	wacom? ( >=sonicde-base/sonic-drawing-tablet-${BASE_MIN}:${SLOT} )
	wallpapers? ( >=sonicde-base/sonic-workspace-wallpapers-${BASE_MIN}:${SLOT} )
	webengine? ( kde-apps/khelpcenter:6 )
	>=kde-plasma/kgamma-${BASE_MIN}:${SLOT}
"
# NOTE sonic-screenies follows the Sonic DE version scheme
# TODO drop after 2027-04-26
case ${PV} in
	*9999) RDEPEND+=" ~sonicde-base/sonic-screenies-${PV}:${SLOT}" ;;
	*)
		RDEPEND+="
			>=sonicde-base/sonic-screenies-$(ver_cut 1-3):${SLOT}
			<sonicde-base/sonic-screenies-15
		"
		;;
esac
# Optional runtime deps: sonicde-base/sonic-desktop-interface, sonicde-base/sonic-screenies
RDEPEND="${RDEPEND}
	accessibility? ( app-accessibility/orca )
	ocr? ( app-text/tesseract )
"

pkg_postinst() {
	if [[ $(tc-get-cxx-stdlib) == "libc++" ]] ; then
		# Workaround for bug #923292 (KDE-bug 479679)
		ewarn "plasmashell and other KDE Plasma components are known to misbehave"
		ewarn "when built with llvm-runtimes/libcxx, e.g. crashing when right-clicking"
		ewarn "on a panel. See bug #923292."
		ewarn ""
		ewarn "A possible (no warranty!) workaround is building llvm-runtimes/libcxx and"
		ewarn "llvm-runtimes/libcxxabi with the following in package.env:"
		ewarn " MYCMAKEARGS=\"-DLIBCXX_TYPEINFO_COMPARISON_IMPLEMENTATION=2\""
		ewarn "You may then need to rebuild dev-qt/* and kde-*/*."
	fi

}
