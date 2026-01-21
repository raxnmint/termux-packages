TERMUX_PKG_HOMEPAGE=https://github.com/elementary/granite
TERMUX_PKG_DESCRIPTION="Library that extends Gtk4 for elementary OS applications"
TERMUX_PKG_LICENSE="LGPL-3.0"
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_VERSION=7.7.0
TERMUX_PKG_SRCURL=https://github.com/elementary/granite/archive/refs/tags/${TERMUX_PKG_VERSION}.tar.gz
TERMUX_PKG_SHA256=e1fe86f95a528fbcc45bbf85b668935dbd2cbf5d128f824d100ff02031ab5441
TERMUX_PKG_DEPENDS="gdk-pixbuf, glib, gtk4, libgee, pango"
TERMUX_PKG_BUILD_DEPENDS="gettext, gobject-introspection, libandroid-complex-math, libgee, gigolo, gvfs, sassc, valac"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
-Ddemo=false
-Ddocumentation=false
"

termux_step_pre_configure() {
	LDFLAGS+=" -Wl,--copy-dt-needed-entries"
	
	# Use host glib-compile-resources instead of target version
	local _GLIB_COMPILE_RESOURCES
	if command -v glib-compile-resources > /dev/null 2>&1; then
		_GLIB_COMPILE_RESOURCES=$(command -v glib-compile-resources)
	else
		termux_error_exit "glib-compile-resources not found on host system. Please install glib2 development tools."
	fi
	
	TERMUX_MESON_CROSSFILE_EXTRA="exe_wrapper = ['env']
[binaries]
glib-compile-resources = '${_GLIB_COMPILE_RESOURCES}'"
	
	termux_setup_meson
}