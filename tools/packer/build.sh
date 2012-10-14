#!/bin/bash

DOZIP=false
DODELETE=true
DOVERBOSE=false
HASSYMPHONYVERSION=false
WORSPACEVERSION="integration"

exec 3>&1
exec 4>&2

bold=`tput bold`
normal=`tput sgr0`

while getopts "s:w:vzdh" opt; do
	case $opt in
		s)
			SYMPHONYVERSION=$OPTARG
			HASSYMPHONYVERSION=true
		;;
		v)
			DOVERBOSE=true
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
			echo "      ${bold}-v${normal}"
			echo "         Verbose output"
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

echo "Building Symphony"  1>&3 2>&4

if [ $DOVERBOSE == false ]; then
	exec 1>/dev/null
	exec 2>/dev/null
fi

echo "Git: cloning Symphony repository"  1>&3 2>&4
git clone git://github.com/symphonycms/symphony-2.git symphony-$SYMPHONYVERSION

echo "Git: checking out desired Symphony version $SYMPHONYVERSION" 1>&3 2>&4
cd symphony-$SYMPHONYVERSION
git checkout $SYMPHONYVERSION

echo "Git: initializing submodules" 1>&3 2>&4
git submodule update --init

echo "Git: cloning Workspace" 1>&3 2>&4
git clone git://github.com/symphonycms/workspace.git

echo "Git: checking out desired workspace version $WORSPACEVERSION" 1>&3 2>&4
cd workspace
git checkout $WORSPACEVERSION
cd ../

echo "Bash: removing Git cruft" 1>&3 2>&4
for i in `find . -name '.git*'`; do
	rm -rf $i
done

cd ../

if [ $DOZIP == true ]; then
	echo "Zip: creating archive" 1>&3 2>&4
	zip -r symphony$SYMPHONYVERSION.zip symphony-$SYMPHONYVERSION
fi

if [ $DODELETE == true ]; then
	echo "Bash: deleting temporary directory" 1>&3 2>&4
	rm -rf symphony-$SYMPHONYVERSION/
fi

echo "Finished" 1>&3 2>&4