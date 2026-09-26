# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="File-free compatibility package for SonicDE KIO extras"
HOMEPAGE="https://github.com/Sonic-DE/sonic-frameworks-io-extras"
LICENSE="metapackage"
SLOT="6/6-sonicde"
KEYWORDS="~amd64 ~arm64 ~loong ~ppc64 ~riscv ~x86"
IUSE="activities ios +man mtp nfs +libproxy openexr samba +sftp taglib debug +handbook test"
RESTRICT="test"
RDEPEND="~sonicde-frameworks/sonic-frameworks-io-extras-${PV}:6[activities=,ios=,man=,mtp=,nfs=,libproxy=,openexr=,samba=,sftp=,taglib=,debug=,handbook=,test=]"
