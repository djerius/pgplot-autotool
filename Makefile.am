## Process this file with automake to produce Makefile.in

ACLOCAL_AMFLAGS = -I m4

SUBDIRS = src sys drivers fonts cpg pgdispd examples

## In automake terminology, this is the `bin' prefix to the `SCRIPTS' primary.

dist_bin_SCRIPTS = rgb.txt

# Made up from sublibs
lib_LTLIBRARIES = libpgplot.la

# We are building libpgplot.la from convenience libraries.  However, all
# the libraries contain Fortran source, and so must be assembled into
# a library using the F77 or FC languages, rather than the C linker
# (this matters on OSX, since the OSX linker has a big downer on
# common blocks, and needs the Fortran voodoo to make it happy).  In
# order to make this happen, we list a dummy Fortran file as a
# source.  This is enough to tell automake to use Fortran in the link.
libpgplot_la_SOURCES = dummy_fortran.f
libpgplot_la_LIBADD =					\
	$(builddir)/src/libpgplot_base.la		\
	$(builddir)/sys/libpgplot_sys.la		\
	$(builddir)/drivers/libpgplot_drivers.la

