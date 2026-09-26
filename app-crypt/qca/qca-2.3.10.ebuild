# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="File-free compatibility package for SonicDE QCA"
HOMEPAGE="https://github.com/Sonic-DE/sonic-crypto-library"
LICENSE="metapackage"
SLOT="2/2-sonicde"
KEYWORDS="~amd64 ~arm ~arm64 ~ppc64 ~riscv ~x86"
IUSE="botan debug doc examples gcrypt gpg logger nss pkcs11 sasl softstore +ssl test"

RESTRICT="!test? ( test )"
RDEPEND="~sonicde-base/sonic-crypto-library-${PV}:2[botan=,debug=,doc=,examples=,gcrypt=,gpg=,logger=,nss=,pkcs11=,sasl=,softstore=,ssl=,test=]"
