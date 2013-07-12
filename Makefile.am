## Process this file with automake to produce Makefile.in

ACLOCAL_AMFLAGS = -I m4

SUBDIRS = src sys drivers fonts cpg pgdispd examples

# rgb.txt is architecture independent, so usually would be installed
# into $pkgdatadir, but PGPLOT prefers a single prefix for both
# fonts.dat and rgb.txt

EXTRA_DIST = rgb.txt

pkg_libexecdir = $(libexecdir)/$(PACKAGE)
install-exec-hook :
	$(MKDIR_P) $(DESTDIR)$(pkg_libexecdir)
	$(INSTALL_DATA) $(srcdir)/rgb.txt $(DESTDIR)$(pkg_libexecdir)/rgb.txt

uninstall-local :
	rm -f $(DESTDIR)$(pkg_libexecdir)/rgb.txt

# Made up from sublibs
lib_LTLIBRARIES = libpgplot.la

# We are building libpgplot.la from convenience libraries.  However, all
# the libraries contain Fortran source, and so must be assembled into
# a library using the F77 or FC languages, rather than the C linker
# (this matters on OSX, since the OSX linker has a big downer on
# common blocks, and needs the Fortran voodoo to make it happy).

# this magic courtesy of the automake docs.  adding a Fortran source
# as a dependency fools automake into linking with Fortran.  putting
# in the EXTRA sources variable means its optional, and the nodist_
# prefix means don't distribute it, so effectively it doesn't need to
# exist.
nodist_EXTRA_libpgplot_la_SOURCES = dummy.f

libpgplot_la_SOURCES =
libpgplot_la_LIBADD =					\
	$(builddir)/src/libpgplot_base.la		\
	$(builddir)/sys/libpgplot_sys.la		\
	$(builddir)/drivers/libpgplot_drivers.la


pkgconfigdatadir = $(libdir)/pkgconfig
pkgconfigdata_DATA = pgplot.pc cpgplot.pc

DISTCLEANFILES = pgplot.pc cpgplot.pc
