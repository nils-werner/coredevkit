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
	cat ../../../../symphony/assets/js/jquery.js > all.js
	cat ../../../../symphony/assets/js/symphony.js >> all.js
	cat ../../../../symphony/assets/js/symphony.collapsible.js >> all.js
	cat ../../../../symphony/assets/js/symphony.orderable.js >> all.js
	cat ../../../../symphony/assets/js/symphony.selectable.js >> all.js
	cat ../../../../symphony/assets/js/symphony.duplicator.js >> all.js
	cat ../../../../symphony/assets/js/symphony.tags.js >> all.js
	cat ../../../../symphony/assets/js/symphony.pickable.js >> all.js
	cat ../../../../symphony/assets/js/symphony.timeago.js >> all.js
	cat ../../../../symphony/assets/js/symphony.notify.js >> all.js
	cat ../../../../symphony/assets/js/symphony.drawer.js >> all.js
	cat ../../../../symphony/assets/js/admin.js >> all.js
	cp all.js ../../../../symphony/assets/js/all.js
fi


if [ $DOCSS == true ]; then
	echo Merge CSS files
	cat ../../../../symphony/assets/css/symphony.css > all.css
	cat ../../../../symphony/assets/css/symphony.legacy.css >> all.css
	cat ../../../../symphony/assets/css/symphony.grids.css >> all.css
	cat ../../../../symphony/assets/css/symphony.frames.css >> all.css
	cat ../../../../symphony/assets/css/symphony.forms.css >> all.css
	cat ../../../../symphony/assets/css/symphony.tables.css >> all.css
	cat ../../../../symphony/assets/css/symphony.drawers.css >> all.css
	cat ../../../../symphony/assets/css/symphony.tabs.css >> all.css
	cat ../../../../symphony/assets/css/symphony.notices.css >> all.css
	cat ../../../../symphony/assets/css/admin.css >> all.css
	cp all.css ../../../../symphony/assets/css/all.css
fi


if [ $DODELETE == true ]; then
	echo Delete temporary files
	rm all.js
	rm all.css
fi
