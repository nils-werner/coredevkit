#!/bin/bash

DOZIP=false
DODELETE=false
HASVERSION=false

WORSPACEVERSION="integration"

bold=`tput bold`
normal=`tput sgr0`

while getopts "v:w:zdh" opt; do
	case $opt in
		v)
			VERSION=$OPTARG
			HASVERSION=true
		;;
		z)
			DOZIP=true
		;;
		d)
			DODELETE=true
		;;
		w)
			WORSPACEVERSION=$OPTARG
		;;
		h)
			echo ""
			echo "  Symphony builder options"
			echo ""
			echo "    Required arguments"
			echo "      ${bold}-v${normal} version"
			echo "         Define Symphony version to be fetched. Must be a valid Git ref."
			echo ""
			echo "    Optional arguments"
			echo "      ${bold}-w${normal} version"
			echo "         Define workspace version to be fetched. Must be a valid Git ref, defaults to integration."
			echo "      ${bold}-z${normal}"
			echo "         Create zip file."
			echo "      ${bold}-d${normal}"
			echo "         Delete fetched data after finishing all jobs."
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

if [ $HASVERSION == false ]; then
	echo "Option ${bold}-v${normal} is required. See ${bold}-h${normal} for all options." >&2
	exit 1
fi

echo Clone repository
git clone git://github.com/symphonycms/symphony-2.git symphony-$VERSION

echo Checkout desired version $VERSION
cd symphony-$VERSION
git checkout $VERSION

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
	zip -r symphony$VERSION.zip symphony-$VERSION
fi

if [ $DODELETE == true ]; then
	echo Delete folder
	rm -rf symphony-$VERSION/
fi