## Process this file with automake to produce Makefile.in

# grfont.dat and rgb.txt are not actually programs but they still need to
# go into bin/

noinst_LTLIBRARIES = libpgplot_sys.la

libpgplot_sys_la_SOURCES = $(F_ROUTINES) $(C_ROUTINES) \
	$(NATIVE_PGPLOT_ROUTINES)

#  List of Fortran routines required for building the package.  This is
#  just a list of all the Fortran source files (excluding BLOCK DATA
#  routines, which are treated separately). Keep this list in alphabetical
#  order so that the subroutine description html comes out in the right 
#  order.

NATIVE_PGPLOT_ROUTINES = grgcom.f

F_ROUTINES = grflun.f grgenv.f grglun.f grgmsg.f grlgtr.f \
	     groptx.f grsy00.f grtrml.f grtter.f


C_ROUTINES = grdate.c  grfileio.c  grgmem.c  gruser.c

if HAVE_TERMIOS
C_ROUTINES += grgetc.c grtermio.c
endif

AM_CFLAGS = -DPG_PPU

AM_FFLAGS = @AM_FFLAGS@
