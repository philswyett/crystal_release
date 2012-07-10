#!/bin/sh
#
#
# Filename: master_release.sh
#
# Please see the 'read_me.txt' for more information.
#

echo
echo "*** This is the master release script for CS and CEL ***"
echo
echo "Do you wish to continue? (yes/no)"
read answer
if [ $answer = "yes" ] ; then
  # Check the system running the script(s) has all the programs
  # installed needed and available for use.
  echo
  echo "*** Checking for programs required by the release script(s) ***"
  echo
  sh sub_scripts/check_dep_programs.sh
  # Edit below path of the CS or CEL tree you are using to release from.
  export SRC_TREE_LOCATION=cs_2_x_x_branch

  echo
  echo "Do you want to make a release of CS or CEL? (cs/cel)"
  read answer

  export PACK_UP=`echo $answer | tr "[:lower:]" "[:upper:]"`
  export PACK_LO=`echo $answer | tr "[:upper:]" "[:lower:]"`

  # CS or CEL not specified. Give user feedback and exit.
  if [ $PACK_UP != "CS" -a $PACK_UP != "CEL" ] ; then
    echo
    echo "Please specify CS or CEL!"
    echo
    echo "*** Exiting... ***"
    echo
    exit
  fi

  if [ $PACK_UP = "CS" ] ; then
    export PACK_FULL="crystalspace"
    export PACK_SHORT="crystal"
    export PACK_REPO="CS"
    export PACK_JOBBER=""
  else
    export PACK_FULL="cel"
    export PACK_SHORT="cel"
    export PACK_REPO="cel"
    export PACK_JOBBER="cel-"
  fi

  # Get version of CS or CEL we wish to create.
  echo
  echo "What version of $PACK_UP do you wish to create?"
  read version
  export CS_VERSION=$version

  # Get which branch we wish to create CS or CEL from.
  echo
  echo "Which branch of $PACK_UP do you wish to create from?"
  read branch
  export CS_BRANCH=$branch

  echo
  echo "*** About to make $PACK_UP version: $CS_VERSION from branch: $CS_BRANCH ***"
  echo
  echo "Do you wish to continue? (yes/no)"
  read answer
  if [ $answer = "yes" ] ; then
    # Jump into CS or CEL directory holding tree.
    cd $SRC_TREE_LOCATION

    echo
    echo "*** You can 'svn switch' the $PACK_UP repository to the $CS_BRANCH branch. ***"
    echo
    echo "Branch is currently at:"
    echo
    svn info | grep URL:
    echo
    echo "Switching would be to:"
    echo
    echo "URL: https://${PACK_SHORT}.svn.sourceforge.net/svnroot/${PACK_SHORT}/${PACK_REPO}/branches/release/V${CS_BRANCH}"
    echo
    echo "Do you wish to switch? (yes/no)"
    read answer
    if [ $answer = "yes" ] ; then
      echo
      echo "Switching..."
      svn switch https://${PACK_SHORT}.svn.sourceforge.net/svnroot/${PACK_SHORT}/${PACK_REPO}/branches/release/V${CS_BRANCH}
    else
      echo
      echo "*** About to perform an svn update. ***"
      echo
      echo "Do you wish to continue? (yes/no)"
      read answer
      if [ $answer = "yes" ] ; then
        svn update
      fi
    fi

    echo
    echo "*** About to regenerate configure for $PACK_UP. ***"
    echo
    echo "Do you wish to continue? (yes/no)"
    read answer
    if [ $answer = "yes" ]; then
      sh ../sub_scripts/regenerate_configure.sh
    fi

    echo
    echo "*** About to run maintenance tasks. ***"
    echo
    echo " - Run configure."
    echo " - Regenerate master header files."
    echo " - Regenerate MSVC project files."
    echo " - Repair texinfo files."
    echo " - Regenerate user manual in HTML."
    echo " - Regenerate python files."
    echo
    echo "Do you wish to continue? (yes/no)"
    read answer
    if [ $answer = "yes" ]; then
      echo
      echo "*** Running configure. ***"
      echo
      sh ../sub_scripts/run_configure.sh
      echo
      echo "*** Regenerating master header files. ***"
      echo
      sh ../sub_scripts/regenerate_master_headers.sh
      echo
      echo "*** Regenerating MSVC project files. ***"
      echo
      sh ../sub_scripts/regenerate_msvc_project_files.sh
      echo
      echo "*** Repairing texinfo files. ***"
      echo
      sh ../sub_scripts/repair_texinfo_files.sh
      echo
      echo "*** Regenerating user manual in HTML. ***"
      echo
      sh ../sub_scripts/regenerate_html_manual.sh
      echo
      echo "*** Regenerating python files. ***"
      echo
      sh ../sub_scripts/regenerate_python_files.sh
      echo
      echo "*** Performing jam distribution cleanup. ***"
      echo
      jam distclean
    fi

    cd ..

    echo
    echo "*** About to prepare $PACK_UP version: $CS_VERSION for release. ***"
    echo "*** Perform a copy of svn, remove .svn folders and make the API docs. ***"
    echo
    echo "Do you wish to continue? (yes/no)"
    read answer
    if [ $answer = "yes" ] ; then
      #sh sub_scripts/${PACK_UP}_prepareForRelease.sh
      sh sub_scripts/prepare_for_release.sh
    fi

    echo
    echo "*** About to make $PACK_UP version: $CS_VERSION release archives. ***"
    echo
    echo "Do you wish to continue? (yes/no)"
    read answer
    if [ $answer = "yes" ] ; then
      # Run sub script to create release archives.
      sh sub_scripts/generate_release_archives.sh
      # Run sub script to create MD5SUMS file for archives.
      sh sub_scripts/generate_md5sums.sh
      # Run sub script to create SHA256SUMS file for archives.
      sh sub_scripts/generate_sha256sums.sh
    fi
  fi
else
  echo
  echo "*** Did we scare you? ;-) ***"
  echo
fi

echo
echo "*** We are finished then. Exiting... Bye. ***"
echo
