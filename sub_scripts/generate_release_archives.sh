#!/bin/sh
#
#
# Filename: generate_release_archives.sh
#

if [ -z "$CS_VERSION" ] ; then
  echo "CS_VERSION env var not set."
  exit
fi

if [ -z "$PACK_FULL" ] ; then
  echo "PACK_FULL env var not set."
  exit
fi

#
# If archives for the version being created already exist. Delete them.
#
if [ -e "$PACK_FULL-src-$CS_VERSION.tar" ] ; then
  rm $PACK_FULL-src-$CS_VERSION.tar
fi

if [ -e "$PACK_FULL-src-$CS_VERSION.tar.gz" ] ; then
  rm $PACK_FULL-src-$CS_VERSION.tar.gz
fi

if [ -e "$PACK_FULL-src-$CS_VERSION.tar.bz2" ] ; then
  rm $PACK_FULL-src-$CS_VERSION.tar.bz2
fi

if [ -e "$PACK_FULL-src-$CS_VERSION.zip" ] ; then
  rm $PACK_FULL-src-$CS_VERSION.zip
fi

#
# Create new release archives.
#
# FIXME: Create one tarball not two.
# Temporary '.tar' archive.
tar cvf $PACK_FULL-src-$CS_VERSION.tar $PACK_FULL-src-$CS_VERSION
# gzip tarball - Creates release '.tar.gz' archive.
gzip -9 $PACK_FULL-src-$CS_VERSION.tar
# Temporary '.tar' archive.
tar cvf $PACK_FULL-src-$CS_VERSION.tar $PACK_FULL-src-$CS_VERSION
# bzip2 tarball - Creates release '.tar.bz2' archive.
bzip2 $PACK_FULL-src-$CS_VERSION.tar
# Creates release '.zip' archive.
zip -9 -r $PACK_FULL-src-$CS_VERSION.zip $PACK_FULL-src-$CS_VERSION
