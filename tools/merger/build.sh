#!/bin/bash

DOJS=false
DOCSS=false
DODELETE=true

bold=`tput bold`
normal=`tput sgr0`

while getopts "jcdh" opt; do
	case $opt in
		j)
			DOJS=true
		;;
		c)
			DOCSS=true
		;;
		d)
			DODELETE=false
		;;
		h)
			echo ""
			echo "  Symphony asset merger options"
			echo ""
			echo "    Optional arguments"
			echo "      ${bold}-j${normal}"
			echo "         Fetch and merge JavaScript files."
			echo "      ${bold}-c${normal}"
			echo "         Fetch and merge CSS files."
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

if [ $DOJS == false ] && [ $DOCSS == false ]; then
	echo "Either option ${bold}-j${normal} or ${bold}-c${normal} is required. See ${bold}-h${normal} for all options." >&2
	exit 1
fi


if [ $DOJS == true ]; then
	echo Merge JS files
	cat ../../../../symphony/assets/js/* > all.js
	cp all.js ../../../../symphony/assets/js/all.js
fi


if [ $DOCSS == true ]; then
	echo Merge CSS files
	cat ../../../../symphony/assets/css/* > all.css
	cp all.css ../../../../symphony/assets/css/all.css
fi


if [ $DODELETE == true ]; then
	echo Delete temporary files
	rm all.js
	rm all.css
fi
