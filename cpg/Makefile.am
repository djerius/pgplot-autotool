## Process this file with automake to produce Makefile.in

# Build the pgbind and cpgdemo programs

noinst_PROGRAMS = pgbind
pgbind_SOURCES = $(PGBIND_ROUTINES)
PGBIND_ROUTINES = pgbind.c

# Use the pgbind program to generate the source files cpgplot.c and cpgplot.h

C_WRAPPERS = cpgplot.c
PUBLIC_INCLUDES = cpgplot.h

# cpgplot.c and cpgplot.h are both built by pgbind in a single invocation.
# this gets parallel makes to work, hopefully on all makes. 

cpgplot.c cpgplot.h: pgbind_prototypes

pgbind_prototypes : pgbind
	grep -h '^C%' $(top_srcdir)/src/pg*.f > ./pgbind_prototypes
	./pgbind bsd -h -w pgbind_prototypes

# Build the actual library

lib_LTLIBRARIES = libcpgplot.la
libcpgplot_la_SOURCES = $(C_WRAPPERS)

pkgincludedir = $(includedir)/$(PACKAGE)
pkginclude_HEADERS = $(PUBLIC_INCLUDES)

# Build the test

PGXLIBS = $(X_LIBS) $(X_EXTRA_LIBS) $(X_PRE_LIBS) -lX11
PGPNGLIBS = -lpng -lz


TESTS = cpgdemo
TESTS_ENVIRONMENT= 						\
	export PGPLOT_FONT=$(top_builddir)/fonts/grfont.dat;	\
	export PGPLOT_RGB=$(top_srcdir)/rgb.txt ;

check_PROGRAMS = cpgdemo
cpgdemo_SOURCES = $(DEMO_ROUTINES)
DEMO_ROUTINES = cpgdemo.c
cpgdemo_LDADD = libcpgplot.la $(top_builddir)/libpgplot.la $(PGXLIBS) $(PGPNGLIBS) @FLIBS@ 

CLEANFILES = $(C_WRAPPERS) $(PUBLIC_INCLUDES) pgbind_prototypes


