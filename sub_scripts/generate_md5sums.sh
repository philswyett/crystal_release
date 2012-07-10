#!/bin/sh
#
#
# Filename: generate_md5sums.sh
#

if [ -z "$CS_VERSION" ] ; then
  echo "CS_VERSION env var not set."
  exit
fi

if [ -z "$PACK_FULL" ] ; then
  echo "CS_VERSION env var not set."
  exit
fi

#
# If an '.MD5SUMS' file already exists for the release being
# created. Delete it.
#
if [ -e "${PACK_FULL}-src-${CS_VERSION}.MD5SUMS" ] ; then
  rm -f ${PACK_FULL}-src-${CS_VERSION}.MD5SUMS
fi

echo
echo "*** Creating MD5SUMS file for release archives. ***"
# Create MD5SUMS file for release archives.
md5sum ${PACK_FULL}-src-$CS_VERSION.tar.bz2 ${PACK_FULL}-src-$CS_VERSION.tar.gz ${PACK_FULL}-src-$CS_VERSION.zip > ${PACK_FULL}-src-${CS_VERSION}.MD5SUMS
