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

Then you can emerge `sonicde-base/sonic-meta` to install the desktop.
