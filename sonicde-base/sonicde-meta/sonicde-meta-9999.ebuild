# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

inherit toolchain-funcs

# Sonic: Mimicing KDE_CATV from plasma.sonic.eclass.
PLASMA_MIN=$(ver_cut 1-3)
[[ ${PV} == *9999* ]] && PLASMA_MIN=6.7

DESCRIPTION="Merge this to pull in all Sonic DE packages"
HOMEPAGE="https://github.com/Sonic-DE"

LICENSE="metapackage"
SLOT="6"
if [[ "${PV}" != *9999 ]]; then
	KEYWORDS="~amd64 ~arm64 ~x86"
fi
IUSE="breeze-theme accessibility bluetooth +browser-integration +crash-handler crypt cups discover +display-manager +elogind +firewall flatpak grub gtk +kwallet +networkmanager ocr oxygen-theme plymouth pulseaudio rdp +sddm sdk +smart systemd thunderbolt unsupported virtualkeyboard wacom +wallpapers webengine X"


RDEPEND="
	sonicde-base/sonic-silver
	sonicde-frameworks/sonic-frameworks-silver-icons
	breeze-theme? ( sonicde-base/sonic-breeze )
	!${CATEGORY}/${PN}:5
	!kde-plasma/khotkeys:5
	>=kde-plasma/aurorae-${PLASMA_MIN}:${SLOT}
	>=sonicde-base/sonic-activity-manager-daemon-${PLASMA_MIN}:${SLOT}
	>=sonicde-base/sonic-terminal-tools-${PLASMA_MIN}:${SLOT}
	>=kde-plasma/kde-cli-tools-common-${PLASMA_MIN}
	>=sonicde-base/sonic-decoration-${PLASMA_MIN}:${SLOT}
	>=sonicde-base/sonic-workspace-addons-${PLASMA_MIN}:${SLOT}
	>=sonicde-frameworks/sonic-frameworks-root-shell-${PLASMA_MIN}[X?]
	>=sonicde-base/sonic-desktop-interface-${PLASMA_MIN}
	>=sonicde-base/sonic-keybind-daemon-${PLASMA_MIN}:${SLOT}[X?]
	>=sonicde-base/sonic-system-info-${PLASMA_MIN}:${SLOT}
	>=sonicde-base/sonic-launcher-menu-edit-${PLASMA_MIN}:${SLOT}
	>=sonicde-base/sonic-night-light-${PLASMA_MIN}:${SLOT}
	>=sonicde-base/sonic-pipewire-${PLASMA_MIN}:${SLOT}
	>=sonicde-base/sonic-screen-${PLASMA_MIN}:${SLOT}
	>=sonicde-base/sonic-screenlocker-${PLASMA_MIN}:${SLOT}
	>=sonicde-base/sonic-ssh-password-prompt-${PLASMA_MIN}:${SLOT}
	>=sonicde-base/sonic-system-stats-${PLASMA_MIN}:${SLOT}
	>=sonicde-base/sonic-write-daemon-${PLASMA_MIN}:${SLOT}
	>=sonicde-base/sonic-screen-library-${PLASMA_MIN}:${SLOT}
	>=sonicde-base/sonic-system-monitor-library-${PLASMA_MIN}:${SLOT}
	>=sonicde-base/sonic-interface-libraries-${PLASMA_MIN}:${SLOT}
	>=sonicde-base/sonic-file-search-ui-${PLASMA_MIN}:${SLOT}
	>=kde-plasma/ocean-sound-theme-${PLASMA_MIN}:${SLOT}
	>=sonicde-base/sonic-activities-${PLASMA_MIN}:${SLOT}
	>=sonicde-base/sonic-activities-stats-${PLASMA_MIN}:${SLOT}
	>=sonicde-base/sonic-qt-theme-bridge-${PLASMA_MIN}:${SLOT}
	>=sonicde-base/sonic-system-monitor-${PLASMA_MIN}:${SLOT}
	>=sonicde-base/sonic-welcome-center-${PLASMA_MIN}:${SLOT}
	>=sonicde-base/sonic-plasma5-support-library-${PLASMA_MIN}:${SLOT}
	>=sonicde-base/sonic-polkit-agent-${PLASMA_MIN}:*
	>=kde-plasma/powerdevil-${PLASMA_MIN}:${SLOT}
	>=sonicde-frameworks/sonic-frameworks-quick-silver-style-${PLASMA_MIN}:${SLOT}
	>=sonicde-base/sonic-desktop-interface-${PLASMA_MIN}:${SLOT}
	>=sonicde-base/sonic-win-${PLASMA_MIN}:${SLOT}[lock]
	>=sonicde-base/sonic-workspace-${PLASMA_MIN}:${SLOT}[X?]
	>=sonicde-base/xdg-desktop-portal-sonicde-${PLASMA_MIN}:${SLOT}
	sys-apps/dbus[elogind?,systemd?]
	sys-auth/polkit[systemd?]
	sys-fs/udisks:2[elogind?,systemd?]
	bluetooth? ( >=sonicde-base/sonic-bluetooth-runtime-${PLASMA_MIN}:${SLOT} )
	browser-integration? ( >=sonicde-base/sonic-browser-integration-${PLASMA_MIN}:${SLOT} )
	crash-handler? (
		!systemd? ( >=kde-plasma/drkonqi-legacy-6.3.80_p20250417:${SLOT} )
		systemd? ( >=sonicde-base/sonic-dr-robotnik-${PLASMA_MIN}:${SLOT} )
	)
	crypt? ( >=sonicde-base/sonic-vault-${PLASMA_MIN}:${SLOT} )
	cups? (
		>=kde-plasma/print-manager-${PLASMA_MIN}:${SLOT}
		net-print/cups-meta
	)
	discover? ( >=kde-plasma/discover-${PLASMA_MIN}:${SLOT} )
	display-manager? (
		sddm? (
			>=kde-plasma/sddm-kcm-${PLASMA_MIN}:${SLOT}
			>=x11-misc/sddm-0.21.0_p20240302[elogind?,systemd?]
		)
		!sddm? ( x11-misc/lightdm )
	)
	elogind? ( sys-auth/elogind[pam] )
	flatpak? ( >=kde-plasma/flatpak-kcm-${PLASMA_MIN}:${SLOT} )
	grub? ( >=kde-plasma/breeze-grub-${PLASMA_MIN}:${SLOT} )
	gtk? (
		>=sonicde-base/sonic-silver-gtk-${PLASMA_MIN}:${SLOT}
		>=sonicde-base/sonic-gtk-theme-bridge-${PLASMA_MIN}:${SLOT}
		sys-apps/xdg-desktop-portal-gtk
		x11-misc/appmenu-gtk-module
	)
	kwallet? ( >=sonicde-frameworks/sonic-frameworks-keyring-pam-${PLASMA_MIN}:${SLOT} )
	networkmanager? (
		>=sonicde-base/sonic-network-manager-${PLASMA_MIN}:${SLOT}
		net-misc/networkmanager[elogind?,systemd?]
	)
	oxygen-theme? (
		>=sonicde-base/sonic-oxygen-icons-6.0.0:*
		>=sonicde-base/sonic-oxygen-${PLASMA_MIN}:${SLOT}[X?]
		>=sonicde-base/sonic-oxygen-sounds-${PLASMA_MIN}:${SLOT}
	)
	plymouth? (
		>=kde-plasma/breeze-plymouth-${PLASMA_MIN}:${SLOT}
		>=kde-plasma/plymouth-kcm-${PLASMA_MIN}:${SLOT}
	)
	pulseaudio? ( >=sonicde-base/sonic-audio-applet-pulse-${PLASMA_MIN}:${SLOT} )
	rdp? ( >=sonicde-base/sonic-rdp-server-${PLASMA_MIN}:${SLOT} )
	sdk? ( >=kde-plasma/plasma-sdk-${PLASMA_MIN}:${SLOT} )
	smart? ( >=sonicde-base/sonic-disks-${PLASMA_MIN}:${SLOT} )
	systemd? (
		>=sys-apps/systemd-257[pam]
		firewall? ( >=sonicde-base/sonic-firewall-${PLASMA_MIN}:${SLOT} )
	)
	thunderbolt? ( >=sonicde-base/sonic-thunderbolt-${PLASMA_MIN}:${SLOT} )
	!unsupported? ( !gui-apps/qt6ct )
	virtualkeyboard? ( >=kde-plasma/plasma-keyboard-${PLASMA_MIN}:${SLOT} )
	wacom? ( >=sonicde-base/sonic-desktop-interface-${PLASMA_MIN}:${SLOT}[input_devices_wacom] )
	wallpapers? ( >=sonicde-base/sonic-workspace-wallpapers-${PLASMA_MIN}:${SLOT} )
	webengine? ( kde-apps/khelpcenter:6 )
	X? (
		>=kde-plasma/kgamma-${PLASMA_MIN}:${SLOT}
		wacom? ( >=sonicde-base/sonic-drawing-tablet-${PLASMA_MIN}:${SLOT} )
	)
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
