## Process this file with automake to produce Makefile.in

SUBDIRS =

if HAVE_X_WINDOW_SYSTEM

  SUBDIRS += xmotif xathena xtk ptk

  bin_PROGRAMS = pgxwin_server
  pgxwin_server_SOURCES = pgxwin_server.c
  pgxwin_server_LDADD = $(X_LIBS) $(X_EXTRA_LIBS) $(X_PRE_LIBS) -lX11

endif

# To change driver list edit configure.ac
BUILT_DRIVER_ROUTINES = @BUILT_DRIVERS@

noinst_LTLIBRARIES = libpgplot_drivers.la
libpgplot_drivers_la_SOURCES = grexec.f

EXTRA_libpgplot_drivers_la_SOURCES = $(DRIVER_ROUTINES)
libpgplot_drivers_la_LIBADD = $(BUILT_DRIVER_ROUTINES)
libpgplot_drivers_la_DEPENDENCIES = $(BUILT_DRIVER_ROUTINES)

dist_noinst_HEADERS = commands.h defines.h  pgxwin.h figdisp_comm.h
dist_noinst_SCRIPTS = makegrexec.pl

grexec.f: $(BUILT_DRIVER_ROUTINES) makegrexec.pl
	$(srcdir)/makegrexec.pl $(BUILT_DRIVER_ROUTINES)

# These are all the driver routines, even if they do not build

DRIVER_ROUTINES = exdriv.f pgdriv.f cadriv.f hgdriv.f lxdriv.f		\
ppdriv.f.in gidriv.f hidriv.f psdriv.f cwdriv.f	\
gldriv.f wddriv.f.in hpdriv.f lsdriv.f nudriv.f qmdriv.f	\
vadriv.f cgdriv.c rvdriv.c x2driv.c xmdriv.c figdisp_comm.c	\
pgxwin.c pndriv.c tkdriv.c xadriv.c xwdriv.c bcdriv.f gvdriv.f		\
ladriv.f lvdriv.f tfdriv.f xedriv.f gcdriv.f todriv.f zedriv.f		\
ccdriv.f ljdriv.f lhdriv.f mfdriv.f hjdriv.f lndriv.f pxdriv.f		\
txdriv.f epdriv.f godriv.f wsdriv.f vbdriv.f pkdriv.c

AM_CFLAGS = -DPG_PPU

AM_FFLAGS = @AM_FFLAGS@

CLEANFILES = grexec.f

EXTRA_DIST = makegrexec.pl
