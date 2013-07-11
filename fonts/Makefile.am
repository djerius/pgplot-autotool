## Process this file with automake to produce Makefile.in

# grfont.dat is a binary formatted version of grfant.txt.  for want of
# a better place, install it in $(libexecdir)/$(PACKAGE).  There
# doesn't seem to be a standard directory (similar to $datadir) for
# architecture _dependent_ data,

noinst_PROGRAMS = pgpack
pgpack_SOURCES = pgpack.f

pkg_libexecdir = $(libexecdir)/$(PACKAGE)

grfont.dat: grfont.txt pgpack
	-rm -f grfont.dat
	./pgpack < $(srcdir)/grfont.txt

install-exec-hook : grfont.dat
	$(MKDIR_P) $(DESTDIR)$(pkg_libexecdir)
	$(INSTALL_DATA) -t $(DESTDIR)$(pkg_libexecdir) grfont.dat

uninstall-hook :
	rm -f $(DESTDIR)/$(pkg_libexecdir)/grfont.dat


EXTRA_DIST = grfont.txt

# grfont.dat is needed to run the tests, so build it before
# installation
BUILT_SOURCES = grfont.dat

CLEANFILES = grfont.dat
