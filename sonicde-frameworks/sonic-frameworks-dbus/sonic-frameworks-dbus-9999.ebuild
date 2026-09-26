# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

QTMIN=6.10.1
VIRTUALDBUS_TEST="true"
inherit ecm frameworks.sonic

DESCRIPTION="Framework for registering services and applications per freedesktop standards"
LICENSE="LGPL-2+"

# slot op: Uses Qt6::GuiPrivate for qtx11extras_p.h
DEPEND="
	>=dev-qt/qtbase-${QTMIN}:6[dbus]
	>=dev-qt/qtbase-${QTMIN}:6=[gui]
"
RDEPEND="${DEPEND}"
BDEPEND=">=dev-qt/qttools-${QTMIN}:6[linguist]"
