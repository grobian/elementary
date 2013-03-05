# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit bzr

DESCRIPTION="Elementary's desktop environment"
HOMEPAGE="http://www.elementaryos.org/ http://launchpad.net/elementaryos/"
EBZR_REPO_URI="lp:~elementary-os/elementaryos/pantheon-xsession-settings"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="libnotify lightdm screensaver"

CDEPEND="
	lightdm? ( x11-misc/lightdm pantheon-base/pantheon-greeter )"
RDEPEND="${CDEPEND}
	gnome-base/gnome-session
	gnome-base/gnome-settings-daemon
	pantheon-base/cerbere
	|| ( pantheon-base/pantheon-dock pantheon-base/plank )
	pantheon-base/slingshot
	pantheon-base/wingpanel
	x11-wm/gala
	libnotify? ( || ( pantheon-base/pantheon-notify x11-misc/notify-osd virtual/notification-daemon ) )
	screensaver? ( || ( gnome-extra/gnome-screensaver x11-misc/xscreensaver ) )"
DEPEND="${CDEPEND}"

src_prepare() {
	# Use gnome as fallback instead of ubuntu
	sed -i 's/ubuntu/gnome/' debian/pantheon.session

	# Use gnome-session wrapper that sets XDG_CURRENT_DESKTOP
	sed -i 's/gnome-session*/pantheon-session/' debian/pantheon.desktop

	# Correct paths
	sed -i 's#/usr/lib/[^/]*/#/usr/libexec/#' autostart/*
}

src_install() {
	insinto /usr/share/gnome-session/sessions
	doins debian/pantheon.session

	insinto /usr/share/xsessions
	doins debian/pantheon.desktop

	insinto /etc/xdg/autostart
	doins autostart/*

	insinto /usr/share/gconf
	doins gconf/*

	insinto /usr/share/pantheon
	doins -r applications

	dobin ${FILESDIR}/pantheon-session
}

pkg_postinst() {
	use lightdm && \
	  /usr/libexec/lightdm/lightdm-set-defaults --keep-old --session=pantheon
}

pkg_postrm() {
	use lightdm && \
	  /usr/libexec/lightdm/lightdm-set-defaults --remove --session=pantheon
}

