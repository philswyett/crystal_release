#!/bin/sh
#
#
# Filename: prepare_for_release.sh
#

if [ -z "$CS_VERSION" ] ; then
  echo "CS_VERSION env var not set."
  exit
fi

if [ -z "$SRC_TREE_LOCATION" ] ; then
  echo "SRC_TREE_LOCATION env var not set."
  exit
fi

if [ -z "$PACK_FULL" ] ; then
  echo "PACK_FULL env var not set."
  exit
fi

#
DEST_DIR=${PACK_FULL}-src-${CS_VERSION}

# FIXME: Give more info about what is goin on here.
echo
echo "Copying '$SRC_TREE_LOCATION' folder to '$DEST_DIR'."
rm -rf $DEST_DIR
cp -R $SRC_TREE_LOCATION $DEST_DIR

#
echo "Removing '.svn' folders from '$DEST_DIR' tree."
find $DEST_DIR -type d -name .svn -exec rm -rf {} \;

echo
echo "*** Generating public API documentation in HTML format. ***"
echo
cd $DEST_DIR

# Split to perform specific configure for CS or CEL.
if [ $PACK_FULL = "crystalspace" ] ; then
  ./configure
else
  # CEL requires the --without-cs switch to avoid trying to find CS and
  # allow maintenance tasks to be performed i.e. generate docs.
  ./configure --without-cs
fi

#
jam apihtml

#
if [ -d "docs/html/api" ] ; then
  rmdir docs/html/api
fi

#
mv out/docs/html/api docs/html

echo
echo "*** Performing jam distribution cleanup. ***"
echo
jam distclean

#
cd ..
