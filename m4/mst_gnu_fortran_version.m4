# LICENSE
#
#   Copyright (c) 2015 Smithsonian Astrophysical Observatory
#   Copyright (c) 2015 Diab Jerius
#
#   This program is free software: you can redistribute it and/or modify it
#   under the terms of the GNU General Public License as published by the
#   Free Software Foundation, either version 3 of the License, or (at your
#   option) any later version.
#
#   This program is distributed in the hope that it will be useful, but
#   WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General
#   Public License for more details.
#
#   You should have received a copy of the GNU General Public License along
#   with this program. If not, see <http://www.gnu.org/licenses/>.
#
#   As a special exception, the respective Autoconf Macro's copyright owner
#   gives unlimited permission to copy, distribute and modify the configure
#   scripts that are the output of Autoconf when processing the Macro. You
#   need not follow the terms of the GNU General Public License when using
#   or distributing such scripts, even though portions of the text of the
#   Macro appear in them. The GNU General Public License (GPL) does govern
#   all other use of the material that constitutes the Autoconf Macro.
#
#  When you make and distribute a modified version of the Autoconf
#   Macro, you may extend this special exception to the GPL to apply
#   to your modified version as well.


# SYNOPSIS
#
#   MST_GNU_FORTRAN_VERSION([LANG])
#
AC_DEFUN([MST_GNU_FORTRAN_VERSION],
[
  AC_REQUIRE([AC_PROG_SED])

  AC_LANG_PUSH([$1])

  AS_VAR_PUSHDEF([mst_gnu_fort_is_gnu],[ac_cv_[]_AC_LANG_ABBREV[]_compiler_gnu])

  AS_VAR_PUSHDEF([mst_gnu_fort_version_cv],[mst_cv_prog_[]_AC_LANG_ABBREV[]_version])

  # [\([0-9][0-9]*\)\.\([0-9][0-9]*\)\.\([0-9][0-9]*\)]
  mst_gfv_pattern='\(@<:@0-9@:>@@<:@0-9@:>@*\)\.\(@<:@0-9@:>@@<:@0-9@:>@*\)\.\(@<:@0-9@:>@@<:@0-9@:>@*\)'

  AS_VAR_IF(
    [mst_gnu_fort_is_gnu],[yes],
    [
      AC_CACHE_CHECK(
       [for GNU _AC_LANG compiler version],
       [mst_gnu_fort_version_cv],
       [
         AC_LANG_CASE(
	   [Fortran 77],[_mst_gnu_fort_compiler=$F77],
	   [Fortran],[_mst_gnu_fort_compiler=$FC],
	   [AC_MSG_FAILURE([ _AC_LANG is not recognized as a language? ])]
	 )
         _mst_gnu_fort_version=`$_mst_gnu_fort_compiler --version`
	 _mst_gnu_fort_version_status=$?
	 AS_IF([test $_mst_gnu_fort_version_status = 0],
  	    [
  	      AS_VAR_SET(
  		    [mst_gnu_fort_version_cv],
  		    [`AS_ECHO(["$_mst_gnu_fort_version"]) | $SED -e "1s/.*@<:@@<:@:blank:@:>@@:>@$mst_gfv_pattern.*/\1.\2.\3/" -e '1!d'`]dnl
  	      )
  	    ],
	    [
  	      AC_MSG_FAILURE( [error running $[]_AC_CC([$1])] )
	    ]
  	 )
       ]
      )
    ]
  )

  AS_VAR_POPDEF([mst_gnu_fort_is_gnu])

  AS_VAR_PUSHDEF([mst_gnu_fort_version],[mst_prog_gnu_[]_AC_LANG_ABBREV[]_version])

  AS_VAR_SET_IF(
    [mst_gnu_fort_version_cv],
    [AC_SUBST(mst_gnu_fort_version,$[]mst_gnu_fort_version_cv)],
    [AC_SUBST(mst_gnu_fort_version,[0.0.0])]
  )

  AC_SUBST(mst_gnu_fort_version[]_major,
    [`AS_ECHO([$[]mst_gnu_fort_version]) | $SED -e "s/^$mst_gfv_pattern/\1/"`]dnl
  )

  AC_SUBST(mst_gnu_fort_version[]_minor,
    [`AS_ECHO([$[]mst_gnu_fort_version]) | $SED -e "s/^$mst_gfv_pattern/\2/"`]dnl
  )

  AC_SUBST(mst_gnu_fort_version[]_patch,
    [`AS_ECHO([$[]mst_gnu_fort_version]) | $SED -e "s/^$mst_gfv_pattern/\3/"`]dnl
  )

  AS_VAR_POPDEF([mst_gnu_fort_version_cv])
  AS_VAR_POPDEF([mst_gnu_fort_version])
  AC_LANG_POP([$1])
])
