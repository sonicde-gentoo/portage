# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

QTMIN=6.10.1
inherit ecm frameworks.sonic

DESCRIPTION="ModemManager bindings for Qt"

LICENSE="LGPL-2"

# requires running environment
RESTRICT="test"

DEPEND="
	>=dev-qt/qtbase-${QTMIN}:6[dbus,xml]
	net-misc/modemmanager
"
RDEPEND="${DEPEND}
	sonicde-frameworks/sonic-frameworks-settings
"
BDEPEND="virtual/pkgconfig"
