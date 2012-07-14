#!/bin/sh
#
#
# Filename: regenerate_configure.sh
#

if [ $PACK_UP = "CS" ] ; then
  sh bin/autogen.sh
else
  sh autogen.sh
fi

if [ $crystal_release_team_mode = "yes" ] ; then
  svn commit -m "Regenerated configure" configure
fi
