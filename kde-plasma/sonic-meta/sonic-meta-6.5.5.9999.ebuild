# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# TODO:
# - Re-add plasma-login-sessions to RDEPEND.
# - Custom 9999 dep on spectacle is commented out since we don't want it
#   to trigger because sonic-meta is 9999 right now.

EAPI=8

inherit toolchain-funcs

# Mimicing KDE_CATV from plasma.sonic.eclass.
PLASMA_MIN=$(ver_cut 1-3)

DESCRIPTION="Merge this to pull in all Sonic DE packages"

LICENSE="metapackage"
SLOT="6"
if [[ "${PV}" != *9999 ]]; then
	KEYWORDS="~amd64 ~arm64 ~loong ~ppc64 ~riscv ~x86"
fi
IUSE="accessibility bluetooth +browser-integration +crash-handler crypt cups
discover +display-manager +elogind +firewall flatpak grub gtk +kwallet
+networkmanager oxygen-theme plymouth pulseaudio rdp +sddm sdk +smart systemd
thunderbolt unsupported wacom +wallpapers webengine X +xwayland"

REQUIRED_USE="^^ ( elogind systemd ) firewall? ( systemd )"

# TODO Disabled deps:
#	>=kde-plasma/plasma-login-sessions-${PLASMA_MIN}:${SLOT}[X?]
RDEPEND="
	!${CATEGORY}/${PN}:5
	!kde-plasma/khotkeys:5
	>=kde-plasma/aurorae-${PLASMA_MIN}:${SLOT}
	>=kde-plasma/breeze-${PLASMA_MIN}:${SLOT}
	>=kde-plasma/kactivitymanagerd-${PLASMA_MIN}:${SLOT}
	>=kde-plasma/kde-cli-tools-${PLASMA_MIN}:${SLOT}
	>=kde-plasma/kde-cli-tools-common-${PLASMA_MIN}
	>=kde-plasma/kdecoration-${PLASMA_MIN}:${SLOT}
	>=kde-plasma/kdeplasma-addons-${PLASMA_MIN}:${SLOT}
	>=kde-plasma/kdesu-gui-${PLASMA_MIN}[X?]
	>=kde-plasma/keditfiletype-${PLASMA_MIN}
	>=kde-plasma/kglobalacceld-${PLASMA_MIN}:${SLOT}[X?]
	>=kde-plasma/kinfocenter-${PLASMA_MIN}:${SLOT}
	>=kde-plasma/kmenuedit-${PLASMA_MIN}:${SLOT}
	>=kde-plasma/knighttime-${PLASMA_MIN}:${SLOT}
	>=kde-plasma/kpipewire-${PLASMA_MIN}:${SLOT}
	>=kde-plasma/kscreen-${PLASMA_MIN}:${SLOT}
	>=kde-plasma/kscreenlocker-${PLASMA_MIN}:${SLOT}
	>=kde-plasma/ksshaskpass-${PLASMA_MIN}:${SLOT}
	>=kde-plasma/ksystemstats-${PLASMA_MIN}:${SLOT}
	>=kde-plasma/kwrited-${PLASMA_MIN}:${SLOT}
	>=kde-plasma/layer-shell-qt-${PLASMA_MIN}:${SLOT}
	>=kde-plasma/libkscreen-${PLASMA_MIN}:${SLOT}
	>=kde-plasma/libksysguard-${PLASMA_MIN}:${SLOT}
	>=kde-plasma/libplasma-${PLASMA_MIN}:${SLOT}
	>=kde-plasma/milou-${PLASMA_MIN}:${SLOT}
	>=kde-plasma/ocean-sound-theme-${PLASMA_MIN}:${SLOT}
	>=kde-plasma/plasma-activities-${PLASMA_MIN}:${SLOT}
	>=kde-plasma/plasma-activities-stats-${PLASMA_MIN}:${SLOT}
	>=kde-plasma/plasma-desktop-${PLASMA_MIN}:${SLOT}
	>=kde-plasma/plasma-integration-${PLASMA_MIN}:${SLOT}
	>=kde-plasma/plasma-systemmonitor-${PLASMA_MIN}:${SLOT}
	>=kde-plasma/plasma-welcome-${PLASMA_MIN}:${SLOT}
	>=kde-plasma/plasma5support-${PLASMA_MIN}:${SLOT}
	>=kde-plasma/polkit-kde-agent-${PLASMA_MIN}:*
	>=kde-plasma/powerdevil-${PLASMA_MIN}:${SLOT}
	>=kde-plasma/qqc2-breeze-style-${PLASMA_MIN}:${SLOT}
	>=kde-plasma/systemsettings-${PLASMA_MIN}:${SLOT}
	>=kde-plasma/sonic-win-${PLASMA_MIN}:${SLOT}[lock]
	>=kde-plasma/sonic-workspace-${PLASMA_MIN}:${SLOT}[X?]
	>=kde-plasma/xdg-desktop-portal-kde-${PLASMA_MIN}:${SLOT}
	sys-apps/dbus[elogind?,systemd?]
	sys-auth/polkit[systemd?]
	sys-fs/udisks:2[elogind?,systemd?]
	bluetooth? ( >=kde-plasma/bluedevil-${PLASMA_MIN}:${SLOT} )
	browser-integration? ( >=kde-plasma/plasma-browser-integration-${PLASMA_MIN}:${SLOT} )
	crash-handler? (
		!systemd? ( >=kde-plasma/drkonqi-legacy-6.3.80_p20250417:${SLOT} )
		systemd? ( >=kde-plasma/drkonqi-${PLASMA_MIN}:${SLOT} )
	)
	crypt? ( >=kde-plasma/plasma-vault-${PLASMA_MIN}:${SLOT} )
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
		>=kde-plasma/breeze-gtk-${PLASMA_MIN}:${SLOT}
		>=kde-plasma/kde-gtk-config-${PLASMA_MIN}:${SLOT}
		sys-apps/xdg-desktop-portal-gtk
		x11-misc/appmenu-gtk-module
	)
	kwallet? ( >=kde-plasma/kwallet-pam-${PLASMA_MIN}:${SLOT} )
	networkmanager? (
		>=kde-plasma/plasma-nm-${PLASMA_MIN}:${SLOT}
		net-misc/networkmanager[elogind?,systemd?]
	)
	oxygen-theme? (
		>=kde-frameworks/oxygen-icons-6.0.0:*
		>=kde-plasma/oxygen-${PLASMA_MIN}:${SLOT}[X?]
		>=kde-plasma/oxygen-sounds-${PLASMA_MIN}:${SLOT}
	)
	plymouth? (
		>=kde-plasma/breeze-plymouth-${PLASMA_MIN}:${SLOT}
		>=kde-plasma/plymouth-kcm-${PLASMA_MIN}:${SLOT}
	)
	pulseaudio? ( >=kde-plasma/plasma-pa-${PLASMA_MIN}:${SLOT} )
	rdp? ( >=kde-plasma/krdp-${PLASMA_MIN}:${SLOT} )
	sdk? ( >=kde-plasma/plasma-sdk-${PLASMA_MIN}:${SLOT} )
	smart? ( >=kde-plasma/plasma-disks-${PLASMA_MIN}:${SLOT} )
	systemd? (
		>=sys-apps/systemd-257[pam]
		firewall? ( >=kde-plasma/plasma-firewall-${PLASMA_MIN}:${SLOT} )
	)
	thunderbolt? ( >=kde-plasma/plasma-thunderbolt-${PLASMA_MIN}:${SLOT} )
	!unsupported? ( !gui-apps/qt6ct )
	wacom? ( >=kde-plasma/plasma-desktop-${PLASMA_MIN}:${SLOT}[input_devices_wacom] )
	wallpapers? ( >=kde-plasma/plasma-workspace-wallpapers-${PLASMA_MIN}:${SLOT} )
	webengine? ( kde-apps/khelpcenter:6 )
	X? (
		>=kde-plasma/kgamma-${PLASMA_MIN}:${SLOT}
		wacom? ( >=kde-plasma/wacomtablet-${PLASMA_MIN}:${SLOT} )
	)
	xwayland? ( >=gui-apps/xwaylandvideobridge-0.4.0_p20250215-r1 )
"
# NOTE spectacle moved from KDE Gear (yy.mm) to KDE Plasma version scheme
# TODO drop after 2027-04-26
case ${PV} in
	# *9999) RDEPEND+=" ~kde-plasma/spectacle-${PV}:${SLOT}" ;;
	*)
		RDEPEND+="
			>=kde-plasma/spectacle-$(ver_cut 1-3):${SLOT}
			<kde-plasma/spectacle-15
		"
		;;
esac
# Optional runtime deps: kde-plasma/plasma-desktop
RDEPEND="${RDEPEND}
	accessibility? ( app-accessibility/orca )
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
