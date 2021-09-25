## Process this file with automake to produce Makefile.in

if COMPILE_PGDISP

bin_PROGRAMS = pgdisp
pgdisp_SOURCES = $(C_ROUTINES)
pgdisp_LDADD = $(X_LIBS) $(X_EXTRA_LIBS) $(X_PRE_LIBS) -lX11
AM_CFLAGS = -DPGDISP

endif

dist_noinst_HEADERS = $(PRIVATE_INCLUDES)
dist_noinst_DATA = figdisp.icon nocursor.icon

C_ROUTINES = cleanup.c getcolors.c handlexevent.c initlock.c ntoh.c    \
resdb.c updatelgtitle.c exposelgwin.c getdata.c initlgluts.c	       \
initwmattr.c pgdisp.c resizelgwin.c waitevent.c figcurs.c getvisuals.c \
initlgwin.c mainloop.c proccom.c returnbuf.c

PRIVATE_INCLUDES =				\
	commands.h				\
	figcurs.h				\
	figdisp.h				\
	getcolors.h				\
	getdata.h				\
	getvisuals.h				\
	globals.h				\
	handlexevent.h				\
	initlgwin.h				\
	initlock.h				\
	mainloop.h				\
	messages.h				\
	proccom.h				\
	returnbuf.h				\
	waitevent.h
