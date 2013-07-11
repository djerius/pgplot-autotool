# SYNOPSIS
#
#   AX_GNU_FORTRAN_VERSION
#
AC_DEFUN([AX_GNU_FORTRAN_VERSION], [
  GFC_VERSION=""
  GFC_VERSION_MAJOR="0"
  GFC_VERSION_MINOR="0"
  GFC_VERSION_PATCH="0"

  ax_gfc_version_compiler=
  AS_IF([test "$GFC" = "yes"],[ax_gfc_version_compiler="$FC"],
        [test "$G77" = "yes"],[ax_gfc_version_compiler="$F77"],
       )
  AS_IF([ test "$ax_gfc_version_compiler"], [
    AS_IF( [$ax_gfc_version_compiler -dumpversion >& /dev/null],
       [ax_gfc_version_option=yes],
       [ax_gfc_version_option=no]
       )
    AS_IF([test "x$ax_gfc_version_option" != "xno"],[
      AC_CACHE_CHECK([gnu fortran compiler version],[ax_cv_gfc_version],[
        ax_cv_gfc_version="`$ax_gfc_version_compiler -dumpversion | head -1 | perl -lane 'print $F@<:@-1@:>@'`"
        AS_IF([test "x$ax_cv_gfc_version" = "x"],[
          ax_cv_gfc_version=""
        ])
      ])
      GFC_VERSION=$ax_cv_gfc_version
      GFC_VERSION_MAJOR=$(echo $GFC_VERSION | cut -d'.' -f1)
      GFC_VERSION_MINOR=$(echo $GFC_VERSION | cut -d'.' -f2)
      GFC_VERSION_PATCH=$(echo $GFC_VERSION | cut -d'.' -f3)
    ])
  ])
  AC_SUBST([GFC_VERSION])
  AC_SUBST([GFC_VERSION_MAJOR])
  AC_SUBST([GFC_VERSION_MINOR])
  AC_SUBST([GFC_VERSION_PATCH])
])
