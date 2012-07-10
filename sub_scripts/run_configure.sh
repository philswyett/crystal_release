#!/bin/sh
#
#
# Filename: run_configure.sh
#

if [ -z "$PACK_FULL" ] ; then
  echo "PACK_FULL env var not set."
  exit
fi

# Split to perform specific configure for CS or CEL.
if [ $PACK_FULL = "crystalspace" ] ; then
  ./configure
else
  # CEL requires the --without-cs switch to avoid trying to find CS and
  # allow maintenance tasks to be performed i.e. generate docs.
  ./configure --without-cs
fi

