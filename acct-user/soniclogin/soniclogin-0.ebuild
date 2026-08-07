# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit acct-user

DESCRIPTION="A user for sonicde-base/sonic-login-manager"

ACCT_USER_GROUPS=( "soniclogin" "video" )
ACCT_USER_HOME="/var/lib/soniclogin"
# Sonic: plasmalogin uses 557, but we're in an overlay, so we're
# supposed to use -1, according to acct-user.eclass.
ACCT_USER_ID=-1

acct-user_add_deps
