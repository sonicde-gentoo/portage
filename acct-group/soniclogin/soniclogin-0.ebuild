# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit acct-group

DESCRIPTION="A group for sonicde-base/sonic-login-manager"

# Sonic: plasmalogin uses 557, but we're in an overlay, so we're
# supposed to use -1, according to acct-group.eclass.
ACCT_GROUP_ID=-1
