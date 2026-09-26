# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Compatibility package for SonicDE sonic-workspace"
HOMEPAGE="https://github.com/Sonic-DE/sonic-workspace"
LICENSE="metapackage"
SLOT="6/6-sonicde"
IUSE="appstream flatpak +fontconfig +ksysguard networkmanager +policykit screencast +semantic-desktop systemd telemetry +wallpaper-metadata debug +handbook test"
RESTRICT="test"
RDEPEND="~sonicde-base/sonic-workspace-${PV}:6[appstream=,flatpak=,fontconfig=,ksysguard=,networkmanager=,policykit=,screencast=,semantic-desktop=,systemd=,telemetry=,wallpaper-metadata=,debug=,handbook=,test=]"
