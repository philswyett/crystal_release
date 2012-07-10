#!/bin/sh
#
#
# Filename: check_dep_programs.sh
#

#
# Function to check if commands we require exist.
#
command_exists ()
{
  echo "Checking for: $1"
  type "$1" ;
}

#
# Check if 'svn' is available. Exit if not.
#
if command_exists svn
then
  echo
else
  echo "Exiting..."
  exit
fi

#
# Check if 'jam' is available. Exit if not.
#
if command_exists jam
then
  echo
else
  echo "Exiting..."
  exit
fi

#
# Check if 'tar' is available. Exit if not.
#
if command_exists tar
then
  echo
else
  echo "Exiting..."
  exit
fi

#
# Check if 'gzip' is available. Exit if not.
#
if command_exists gzip
then
  echo
else
  echo "Exiting..."
  exit
fi

#
# Check if 'zip' is available. Exit if not.
#
if command_exists zip
then
  echo
else
  echo "Exiting..."
  exit
fi

#
# Check if 'bzip2' is available. Exit if not.
#
if command_exists bzip2
then
  echo
else
  echo "Exiting..."
  exit
fi

#
# Check if 'md5sum' is available. Exit if not.
#
if command_exists md5sum
then
  echo
else
  echo "Exiting..."
  exit
fi

#
# Check if 'sha256sum' is available. Exit if not.
#
if command_exists sha256sum
then
  echo
else
  echo "Exiting..."
  exit
fi
