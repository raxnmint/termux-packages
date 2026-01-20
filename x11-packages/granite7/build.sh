TERMUX_PKG_HOMEPAGE=https://github.com/elementary/granite
TERMUX_PKG_DESCRIPTION="Library that extends Gtk4 for elementary OS applications"
TERMUX_PKG_LICENSE="LGPL-3.0"
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_VERSION=7.7.0
TERMUX_PKG_SRCURL=https://github.com/elementary/granite/archive/refs/tags/${TERMUX_PKG_VERSION}.tar.gz
TERMUX_PKG_SHA256=e1fe86f95a528fbcc45bbf85b668935dbd2cbf5d128f824d100ff02031ab5441
TERMUX_PKG_DEPENDS="gdk-pixbuf, glib, gtk4, libgee, pango"
TERMUX_PKG_BUILD_DEPENDS="gettext, gobject-introspection, sassc, valac"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
-Ddemo=false
-Ddocumentation=false
"

termux_step_pre_configure() {
	LDFLAGS+=" -Wl,--copy-dt-needed-entries"
	termux_setup_meson
}
