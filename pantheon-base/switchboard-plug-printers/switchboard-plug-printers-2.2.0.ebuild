# Copyright 1999-2020 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

VALA_MIN_API_VERSION=0.34

inherit meson vala

DESCRIPTION="A printers plug for Switchboard"
HOMEPAGE="https://github.com/elementary/switchboard-plug-printers"
SRC_URI="https://github.com/elementary/switchboard-plug-printers/archive/${PV}.tar.gz -> ${P}.tar.gz"

KEYWORDS="amd64"
LICENSE="GPL-3"
SLOT="0"
IUSE=""

RDEPEND="
	dev-libs/glib:2
	dev-libs/granite:0
	net-print/cups
	pantheon-base/switchboard
	x11-libs/gtk+:3
"
DEPEND="${RDEPEND}
	$(vala_depend)
	virtual/pkgconfig
"

src_prepare() {
	eapply_user
	vala_setup
}
