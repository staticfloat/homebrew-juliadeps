#!/bin/bash

function grab_all_bottles
{
	# Get download url from brew
	DOWNLOAD_URL=$(brew fetch $1 | grep "==> Downloading " | awk '{ print $3 }')
	OS_MARKER="thisismyosmarkerthatprobably"
	OS_LIST="yosemite mavericks el_capitan"

	for OS in $OS_LIST; do
		DOWNLOAD_URL=$(echo $DOWNLOAD_URL | sed "s/$OS/$OS_MARKER/g")
	done

	# Grab bottles for each OS:
	for OS in $OS_LIST; do
		OS_URL=$(echo $DOWNLOAD_URL | sed "s/$OS_MARKER/$OS/g")

		echo "Downloading $OS bottle for $1..."
		wget -q $OS_URL -O /tmp/bottle_downloads/$(basename $OS_URL)
	done
}

mkdir -p /tmp/bottle_downloads

FORMULA_NAME="$1"
if [[ -z "$FORMULA_NAME" ]]; then
	FORMULA_NAME=$(grep -L "root_url" *.rb)
fi

for name in $FORMULA_NAME; do
	echo "Processing ${name%.*}..."
	grab_all_bottles "${name%.*}"
done

for name in /tmp/bottle_downloads/$FORMULA_NAME*; do
	echo "Uploading $(basename $name)..."
	aws put --public "juliabottles/$(basename $name)" "$name"
done
