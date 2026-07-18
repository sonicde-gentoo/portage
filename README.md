# SonicDE Gentoo Ports

Overlay containing SonicDE-related packages.

## Adding

Put the following in `/etc/portage/repos.conf/sonicde.conf`:

```conf
[sonicde]
location = /var/db/repos/sonicde
sync-type = git
sync-uri = https://github.com/sonicde-gentoo/portage
```

Then sync:

```
# emaint sync -r sonicde
```

Now, accept unstable keywords for all packages in the `sonicde`
overlay. In `/etc/portage/package.accept_keywords/00-sonicde`:

```
*/*::sonicde
```

Then emerge `sonicde-base/sonic-meta` to install the desktop.

## Using newer Plasma

The latest Plasma with unstable keywords can also be used with SonicDE.
The KDE overlay provides a package.accept_keywords file to unmask the
necessary KDE packages:

https://gitweb.gentoo.org/proj/kde.git/tree/Documentation/package.accept_keywords

Copy or symlink the `kde-plasma-6.7.keywords` file into
`/etc/portage/package.accept_keywords`.  It's not necessary to use any
ebuilds from the KDE overlay.
