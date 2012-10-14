#!/bin/bash

DOZIP=false
DODELETE=true
HASSYMPHONYVERSION=false

WORSPACEVERSION="integration"

bold=`tput bold`
normal=`tput sgr0`

while getopts "s:w:zdh" opt; do
	case $opt in
		s)
			SYMPHONYVERSION=$OPTARG
			HASSYMPHONYVERSION=true
		;;
		z)
			DOZIP=true
		;;
		d)
			DODELETE=false
		;;
		w)
			WORSPACEVERSION=$OPTARG
		;;
		h)
			echo ""
			echo "  Symphony builder options"
			echo ""
			echo "    Required arguments"
			echo "      ${bold}-s${normal} version"
			echo "         Define Symphony version to be fetched. Must be a valid Git ref."
			echo ""
			echo "    Optional arguments"
			echo "      ${bold}-w${normal} version"
			echo "         Define workspace version to be fetched. Must be a valid Git ref, defaults to integration."
			echo "      ${bold}-z${normal}"
			echo "         Create zip file."
			echo "      ${bold}-d${normal}"
			echo "         Do not delete fetched data after finishing all jobs."
			echo "      ${bold}-h${normal}"
			echo "         This help."
			echo ""
			exit 0
		;;
		\?)
			echo "Invalid option: ${bold}-$OPTARG${normal}" >&2
			exit 1
		;;
		:)
			echo "Option ${bold}-$OPTARG${normal} requires an argument." >&2
			exit 1
		;;
	esac
done

if [ $HASSYMPHONYVERSION == false ]; then
	echo "Option ${bold}-v${normal} is required. See ${bold}-h${normal} for all options." >&2
	exit 1
fi

echo Clone repository
git clone git://github.com/symphonycms/symphony-2.git symphony-$SYMPHONYVERSION

echo Checkout desired version $SYMPHONYVERSION
cd symphony-$SYMPHONYVERSION
git checkout $SYMPHONYVERSION

echo Initialize submodules
git submodule update --init

echo Clone Workspace
git clone git://github.com/symphonycms/workspace.git

echo Checkout latest version of workspace
cd workspace
git checkout $WORSPACEVERSION
cd ../

echo Remove Git cruft
for i in `find . -name '.git*'`; do
	rm -rf $i
done

cd ../

if [ $DOZIP == true ]; then
	echo Zip it
	zip -r symphony$SYMPHONYVERSION.zip symphony-$SYMPHONYVERSION
fi

if [ $DODELETE == true ]; then
	echo Delete folder
	rm -rf symphony-$SYMPHONYVERSION/
fi
