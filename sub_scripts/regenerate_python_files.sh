#!/bin/sh
#
#
# Filename: regenerate_python_files.sh
#

if [ $PACK_UP = "CS" ] ; then
  jam cspythonswig

  jam cspythonfreeze

  jam pythonfreeze
else
  echo "*** We are not generating for CEL at present. ***"
fi

