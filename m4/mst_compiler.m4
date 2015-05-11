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


#
# SYNOPSIS
#
#   MST_COMPILER_64BIT([FLAGS],[ACTION-SUCCESS],[ACTION-FAILURE])
#
#
# DESCRIPTION
#
#   Determine if the current compiler generates 64bit executables with
#   the specified flags
#
AC_DEFUN([MST_COMPILER_64BIT],
[
  AS_VAR_PUSHDEF([_mst_comp_64bit_cv],[mst_cv_compiler_64bit_[]_AC_LANG_ABBREV[]_$1])dnl
  AC_CACHE_VAL(
    _mst_comp_64bit_cv,
    [ MST_GREP_EXE_TYPE([are 64-bit m4_ifblank([$1],[by default],[with flags $1])],
      			[64-bit],
    		        [AS_VAR_SET(_mst_comp_64bit_cv,[yes])],
		        [AS_VAR_SET(_mst_comp_64bit_cv,[no])],
			[$1],
      )
    ]
  )

  AS_VAR_IF(_mst_comp_64bit_cv,[yes],
    [m4_default([$2], :)],
    [m4_default([$3], :)]
  )
  AS_VAR_POPDEF([_mst_comp_64bit_cv])
])


#
# SYNOPSIS
#
#   MST_FORTRAN_64BIT([LANG])
#
#
# DESCRIPTION
#
#   If the default is for the C compiler/linker to produce 64bit
#   programs, see if the Fortran (specifie by LANG) compiler will do the same, or if
#   it needs a flag.
#
AC_DEFUN([MST_FORTRAN_64BIT],
[
  AC_LANG_PUSH([$1])
  AS_VAR_PUSHDEF([_mst_fort_64bit_cv],[mst_cv_prog_fortran_64bit_[]_AC_LANG_ABBREV])

  AC_CACHE_VAL(
    [_mst_fort_64bit_cv],
    [
      AC_LANG_PUSH([C])
      MST_COMPILER_64BIT([],[c_64bit=yes],[c_64bit=no])
      AC_LANG_POP([C])

      MST_COMPILER_64BIT([],[fort_64bit=yes],[fort_64bit=no])

      AS_IF(
        [test $c_64bit = yes && test $fort_64bit = no],
      	[
      	 AX_CHECK_COMPILE_FLAG(
      	   [-m64],
      	   [
      	     MST_COMPILER_64BIT(
      	       [-m64],
      	       [AS_VAR_SET(_mst_fort_64bit_cv,[-m64])],
      	       [AS_VAR_SET(_mst_fort_64bit_cv,[fail])],
             )
           ],
      	   [AS_VAR_SET(_mst_fort_64bit_cv,[fail])],
         )
      	],
        [AS_VAR_SET(_mst_fort_64bit_cv,[yes])],
      )

      AS_VAR_IF(_mst_fort_64bit_cv,fail,[Unable to determine which flag will make $1 generate 64 bit executables])
    ]
  )

  dnl add the flag to the compiler *variable*, not the
  dnl compiler flags.  this is because the 64 bit flag needs to be
  dnl used in places where FFLAGS/FCFLAGS are not used, so setting them there
  dnl doesn't do the trick.
  AS_VAR_IF(_mst_fort_64bit_cv,yes,
    [],
    [
      _AC_CC([$1])="$[]_AC_CC([$1]) $[]_mst_fort_64bit_cv"
    ]
  )
  AC_LANG_POP([$1])
  AS_VAR_POPDEF([_mst_fort_64bit_cv])

])
