#!/bin/sh
#
#
# Filename: regenerate_msvc_project_files.sh
#

if [ -z "$PACK_FULL" ] ; then
  echo "PACK_FULL env var not set."
  exit
fi

#
jam -sMSVCGEN_SILENT=yes msvcgen

if [ $PACK_FULL = "crystalspace" ] ; then
  # Remove files from directories.
  rm -f mk/msvc/*
  rm -f mk/msvc8/*
  rm -f mk/msvc9/*
  rm -f mk/msvc10/*

  # Copy newly generated files to correct location.
  cp -f out/mk/msvc/* mk/msvc/
  cp -f out/mk/msvc8/* mk/msvc8/
  cp -f out/mk/msvc9/* mk/msvc9/
  cp -f out/mk/msvc10/* mk/msvc10/
else
  # FIXME
  echo "Do CEL"
fi
