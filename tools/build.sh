#!/bin/bash

DOZIP=false
DODELETE=false

while getopts "v:zd" opt; do
	case $opt in
		v)
			VERSION=$OPTARG
		;;
		z)
			DOZIP=true
		;;
		d)
			DODELETE=true
		;;
		\?)
			echo "Invalid option: -$OPTARG" >&2
			exit 1
		;;
		:)
			echo "Option -$OPTARG requires an argument." >&2
			exit 1
		;;
	esac
done

echo Clone repository
git clone git://github.com/symphonycms/symphony-2.git symphony-$VERSION &> /dev/null

echo Checkout desired version $VERSION
cd symphony-$VERSION
git checkout $VERSION &> /dev/null

echo Initialize submodules
git submodule update --init &> /dev/null

echo Clone Workspace
git clone git://github.com/symphonycms/workspace.git &> /dev/null

echo Checkout latest version of workspace
cd workspace
git checkout integration &> /dev/null
cd ../

echo Remove Git cruft
for i in `find . -name '.git*'`; do
	rm -rf $i
done

cd ../

if [ $DOZIP == true ]; then
	echo Zip it
	zip -r symphony$VERSION.zip symphony-$VERSION > /dev/null
fi

if [ $DODELETE == true ]; then
	echo Delete folder
	rm -rf symphony-$VERSION/
fi