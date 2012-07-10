#!/bin/sh
#
#
# Filename: generate_sha256sums.sh
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
# If an '.SHA256SUMS' file already exists for the release being
# created. Delete it.
#
if [ -e "${PACK_FULL}-src-${CS_VERSION}.SHA256SUMS" ] ; then
  rm -f ${PACK_FULL}-src-${CS_VERSION}.SHA256SUMS
fi

echo
echo "*** Creating SHA256SUMS file for release archives. ***"
# Create SHA256SUMS file for release archives.
sha256sum ${PACK_FULL}-src-$CS_VERSION.tar.bz2 ${PACK_FULL}-src-$CS_VERSION.tar.gz ${PACK_FULL}-src-$CS_VERSION.zip > ${PACK_FULL}-src-${CS_VERSION}.SHA256SUMS
