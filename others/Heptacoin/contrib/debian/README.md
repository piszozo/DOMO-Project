
Debian
====================
This directory contains files used to package heptacoind/heptacoin-qt
for Debian-based Linux systems. If you compile heptacoind/heptacoin-qt yourself, there are some useful files here.

## heptacoin: URI support ##


heptacoin-qt.desktop  (Gnome / Open Desktop)
To install:

	sudo desktop-file-install heptacoin-qt.desktop
	sudo update-desktop-database

If you build yourself, you will either need to modify the paths in
the .desktop file or copy or symlink your heptacoin-qt binary to `/usr/bin`
and the `../../share/pixmaps/heptacoin128.png` to `/usr/share/pixmaps`

heptacoin-qt.protocol (KDE)

