# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Common-data compatibility package for Sonic Terminal Tools"
HOMEPAGE="https://github.com/Sonic-DE/sonic-terminal-tools"
LICENSE="metapackage"
SLOT="0/0-sonicde"
IUSE="+handbook"

RDEPEND=">=sonicde-base/sonic-terminal-tools-${PV}:6"
