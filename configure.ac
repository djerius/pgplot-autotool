dnl    Initialisation: package name and version number
AC_INIT(pgplot, 5.2.2-3_03, djerius@cpan.org)

AC_PREREQ(2.69)
AC_CONFIG_MACRO_DIR([m4])

# cannot run parallel tests as all tests require keyboard input
AM_INIT_AUTOMAKE([1.14 -Wall foreign serial-tests ])

dnl    Sanity-check: name a file in the source directory -- if this
dnl    isn't found then configure will complain
AC_CONFIG_SRCDIR([src/pgbeg.f])


dnl    Find required versions of the programs we need for configuration
AC_PROG_CC
AC_PROG_AWK
AC_PROG_F77
AC_PROG_INSTALL
AC_PROG_LN_S
AC_PROG_MAKE_SET
AC_PROG_RANLIB
AC_PROG_MKDIR_P
AM_PROG_AR
AC_PROG_LIBTOOL

dnl    Yes Virginia, there are boxes without Fortran. Drag them back to the '70s
AS_IF([test "x$F77" = x ],
      [AC_MSG_ERROR([No Fortran compiler found; Cannot build without one. Aborting])
      ]
)

dnl     Checks for libraries

dnl     On Ubuntu 13.04, need to explicitly pull in libm to resolve
dnl     sincos
AC_CHECK_LIB(m, sincos)


dnl     Checks for header files.
AC_HEADER_STDC
AC_PATH_XTRA
AC_CHECK_HEADERS([fcntl.h limits.h memory.h netdb.h netinet/in.h stddef.h sys/file.h sys/socket.h sys/systeminfo.h sys/time.h termios.h unistd.h values.h])

dnl    get the flags required to link other languages against fortran
dnl    using their compilers, not fortran
AC_F77_LIBRARY_LDFLAGS

dnl   Checks for library functions.
AC_FUNC_MALLOC
AC_FUNC_REALLOC
AC_CHECK_FUNCS([gethostbyname gethostname memset select socket sqrt strrchr strtol sysinfo])

dnl   These are the driver files that will actually be built.
dnl   In true autoconf style, we do not attempt to generate this list
dnl   automatically (see the automake manual's FAQ for justification).

drivers="exdriv.lo pgdriv.lo cadriv.lo hgdriv.lo lxdriv.lo  vtdriv.lo hidriv.lo psdriv.lo ttdriv.lo cwdriv.lo gldriv.lo nedriv.lo hpdriv.lo lsdriv.lo nudriv.lo qmdriv.lo vadriv.lo cgdriv.lo nexsup.lo rvdriv.lo x2driv.lo xmdriv.lo figdisp_comm.lo pgxwin.lo tkdriv.lo pkdriv.lo xadriv.lo"

dnl    %VAL is used for some memory handling. Under 64bit pointers are
dnl    8 bytes. Files that require this are configured here
AC_CHECK_SIZEOF([void *])
AC_SUBST([SIZEOF_VOID_P],[$ac_cv_sizeof_void_p])
AC_CONFIG_FILES([drivers/ppdriv.f
	         drivers/gidriv.f
	         drivers/wddriv.f
		])

dnl    gfortran < 4.3 can't handle %VAL on 64 bit systems, so just
dnl    don't compile drivers that use it.
AX_GNU_FORTRAN_VERSION
AS_IF([test -n "$GFC_VERSION" -a "$GFC_VERSION_MAJOR" -eq 4 -a "$GFC_VERSION_MINOR" -lt 3 ],
      [],
      [drivers="$drivers gidriv.lo ppdriv.lo wddriv.lo"]
     )

# these provided required linker and compile flags for PGPLOT's pkg-config metadata files
AC_SUBST([PKG_CONFIG_LIBS])
AC_SUBST([PKG_CONFIG_CFLAGS])

dnl   Make sure that X libs are included in tests.
dnl   Apple puts libpng in the X11 distribution.
dnl   Oddly gcc and cpp (in Snow Leopard) know how to find X11 include
dnl   files without being told.  This means that the standard
dnl   configure test does not both adding any include directories for
dnl   X. This is unfortunate because PNG is sitting there but does not
dnl   have the magical <X11/...> prefix to give cpp a hint.  We add
dnl   the path here on the basis that it won't hurt anyone else.
X_LIBS="$X_LIBS $X_PRE_LIBS -lX11 $X_EXTRA_LIBS"
LIBS="$LIBS $X_LIBS"
X_CFLAGS="$X_CFLAGS -I/usr/X11/include"
CPPFLAGS="$CPPFLAGS $X_CFLAGS"


dnl   Add the png driver if the PNG header and library are available.
dnl   On some systems both png 1.2.x and png 1.5+ are installed.  They
dnl   are not ABI compatible, and on some systems it's possible to pull
dnl   in the header for one and libs for the other.  don't ask...

dnl   Try to use the pkg-config files if possible, as they
dnl   explicitly direct us to the version specific headers and
dnl   libraries.  If that doesn't work, try to find them in the
dnl   standard places and pray.

have_png=no
PKG_CHECK_MODULES(
   [PNG],
   [libpng],
   [have_png=yes
dnl   add png to our own pkg-config files' requirements
    PKG_CONFIG_REQUIRES="${PKG_CONFIG_REQUIRES}[,]libpng"
   ],
   [AC_CHECK_HEADER(
        [png.h],
	[AC_CHECK_LIB([png],[png_create_write_struct],
	    [PNG_LIBS="-lpng -lz"
	     PKG_CONFIG_LIBS="$PKG_CONFIG_LIBS $PNG_LIBS"
	     have_png=yes
	    ],
	    [AC_MSG_WARN(PNG libraries not found)],
	    [-lz]
	 )
        ]
     )
    ]
)

dnl   Add required flags and drivers if we've got libpng.
AS_IF([test $have_png = yes],
      [ drivers="$drivers pndriv.lo"
	LIBS="$LIBS $PNG_LIBS"
	CPPFLAGS="$CPPFLAGS $PNG_CFLAGS"
      ]
)


dnl   clean up pkg-config requires line
PKG_CONFIG_REQUIRES=`echo $PKG_CONFIG_REQUIRES | ${ac_cv_path_SED} "s/^,//"`
AC_SUBST(PKG_CONFIG_REQUIRES)

BUILT_DRIVERS="$drivers xwdriv.lo"

AC_SUBST(BUILT_DRIVERS)

dnl    Stuff required for xathena
have_athena="yes"
AC_ARG_WITH([athena],
	     AC_HELP_STRING([--with-athena[=path]],
	     [use Xaw3d (default location /usr/X11R6/)]),
  [if test "$withval" = "yes"; then
    # Default place
    LIBS="$LIBS $X_LIBS"
    CPPFLAGS="$CPPFLAGS $X_CFLAGS"
  elif test "$withval" = "no"; then
    # We do nothing
    have_athena="no"
  else
    XALIBDIR=$withval/lib
    XAINCDIR=$withval/include
    LIBS="$LIBS -L$XALIBDIR"
    CPPFLAGS="$CPPFLAGS -I$XAINCDIR"
    PKG_CONFIG_LIBS="$PKG_CONFIG_LIBS -L$XALIBDIR"
    PKG_CONFIG_CFLAGS="$PKG_CONFIG_CFLAGS -L$XAINCDIR"
  fi])

dnl    Hack and slash for the Mac. This should only add goodness to
dnl    non-Mac builds in the case where whoever did their filesystem
dnl    have done something as wierd as Apple.
if test "$have_athena" = "yes"; then
  AC_CHECK_HEADER([X11/Xaw3d/Simple.h], have_xa3dheader=yes )
  AC_CHECK_LIB(Xaw3d, XawInitializeWidgetSet, have_xa3dlib=yes )
else
  have_xa3dheader="no"
  have_xa3dlib="no"
fi

AM_CONDITIONAL( HAVE_XATHENA, \
    [test "$have_xa3dheader" = "yes" && test "$have_xa3dlib" = "yes" ])

dnl    tcl shipes with a tcl.m4 autoconf macro library.  This should be
dnl    used to set up the ptk and xtk drivers. until then, disable TK
AM_CONDITIONAL( HAVE_TK, false )

dnl    xmotif
have_motif="yes"
AC_ARG_WITH([motif],
	     AC_HELP_STRING([--with-motif[=path]],
	     [use XMotif (default location /usr/X11R6)]),
  [if test "$withval" = "yes"; then
    # Default place
    LIBS="$LIBS $X_LIBS"
    CPPFLAGS="$CPPFLAGS $X_CFLAGS"
  elif test "$withval" = "no"; then
    # We do nothing
    have_motif="no"
  else
    XMLIBDIR=$withval/lib
    XMINCDIR=$withval/include
    LIBS="$LIBS -L$XMLIBDIR"
    CPPFLAGS="$CPPFLAGS -I$XMINCDIR"
    PKG_CONFIG_LIBS="$PKG_CONFIG_LIBS -L$XMLIBDIR"
    PKG_CONFIG_CFLAGS="$PKG_CONFIG_CFLAGS -L$XMINCDIR"
  fi])

if test "$have_motif" = "yes"; then
   AC_CHECK_HEADER([Xm/XmP.h], have_xmheader=yes )
   AC_CHECK_LIB(Xm, XmScrolledWindowSetAreas, have_xmlib=yes )
else
   have_xmheader="no"
   have_xmlib="no"
fi

AM_CONDITIONAL( HAVE_XMOTIF, \
   [test "$have_xmheader" = "yes" && test "$have_xmlib" = "yes"] )


dnl    If you wish to configure extra files, you can add them to this
dnl    declaration.
AC_CONFIG_FILES([Makefile
		 cpg/Makefile
		 fonts/Makefile
		 pgdispd/Makefile
		 src/Makefile
		 sys/Makefile
		 examples/Makefile
		 drivers/Makefile
		 drivers/xathena/Makefile
		 drivers/xtk/Makefile
		 drivers/ptk/Makefile
		 drivers/xmotif/Makefile
		])

dnl    Add X libraries at end
PKG_CONFIG_LIBS="$PKG_CONFIG_LIBS $X_LIBS"
PKG_CONFIG_CFLAGS="$PKG_CONFIG_CFLAGS $X_CFLAGS"

dnl    pkg-config files
AC_CONFIG_FILES([pgplot.pc
	         cpgplot.pc
		 ])

dnl    This is the bit that does the actual work
AC_OUTPUT
