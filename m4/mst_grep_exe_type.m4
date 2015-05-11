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

AC_DEFUN([_MST_GREP_EXE_TYPE_PREREQS],
[
  AC_REQUIRE([AC_PROG_GREP])
  if test -z "$FILE" ; then
     AC_PATH_PROG([FILE],[file])
  fi
])

#
# SYNOPSIS
#
#   MST_GREP_EXE_TYPE([MESSAGE], [PATTERN],
#                     [ACTION-SUCCESS],
#	              [ACTION-FAILURE],
#	              [EXTRA-FLAGS], [INPUT])
#
# DESCRIPTION
#
#   Compile and link an executable with the current language and grep
#   the output of the file command run on the resultant executable


AC_DEFUN([MST_GREP_EXE_TYPE],
[
  AC_REQUIRE([_MST_GREP_EXE_TYPE_PREREQS])
  AS_VAR_PUSHDEF([_mst_grep_exe_type_cv],[mst_cv_grep_exe_type_[]_AC_LANG_ABBREV[]_$2_$5])dnl
  AC_CACHE_CHECK(
    [if _AC_LANG compiler produces executables which $1],
    _mst_grep_exe_type_cv,
    [ mst_grep_exe_save_flags=$[]_AC_LANG_PREFIX[]FLAGS
      _AC_LANG_PREFIX[]FLAGS="$[]_AC_LANG_PREFIX[]FLAGS $5"
      AC_LINK_IFELSE(
       [m4_default([$6],[AC_LANG_PROGRAM()])],
       [AS_IF([$FILE conftest$EXEEXT | $GREP -q "$2"],
	  [AS_VAR_SET(_mst_grep_exe_type_cv,[yes])],
	  [AS_VAR_SET(_mst_grep_exe_type_cv,[no])],
	 )
       ],
       [AC_MSG_ERROR([unable to compile _AC_LANG compiler test code])]
      )
      _AC_LANG_PREFIX[]FLAGS=$mst_grep_exe_save_flags
    ]
  )
  AS_VAR_IF(_mst_grep_exe_type_cv,yes,
    [m4_default([$3], :)],
    [m4_default([$4], :)])
  AS_VAR_POPDEF([_mst_grep_exe_type_cv])
])

