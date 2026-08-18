# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

ECM_TEST="forceoptional"
QTMIN=6.10.1
inherit ecm frameworks.sonic

DESCRIPTION="Framework for searching and managing metadata"

LICENSE="LGPL-2+"

RESTRICT="test" # bug 624250

DEPEND="
	>=dev-db/lmdb-0.9.17
	>=dev-qt/qtbase-${QTMIN}:6[dbus,gui,widgets]
	>=dev-qt/qtdeclarative-${QTMIN}:6
	=sonicde-frameworks/sonic-frameworks-settings-${KDE_CATV}*:6
	=sonicde-frameworks/sonic-frameworks-core-addons-${KDE_CATV}*:6
	=sonicde-frameworks/sonic-frameworks-crash-handler-${KDE_CATV}*:6
	=sonicde-frameworks/sonic-frameworks-dbus-${KDE_CATV}*:6
	=sonicde-frameworks/sonic-frameworks-file-metadata-${KDE_CATV}*:6
	=sonicde-frameworks/sonic-frameworks-internationalization-${KDE_CATV}*:6
	=sonicde-frameworks/sonic-frameworks-idle-tracker-${KDE_CATV}*:6
	=sonicde-frameworks/sonic-frameworks-io-${KDE_CATV}*:6
	=sonicde-frameworks/sonic-frameworks-device-integration-${KDE_CATV}*:6
"
RDEPEND="${DEPEND}
	!${CATEGORY}/${PN}:5[-kf6compat(-)]
"
