#!/usr/bin/env bash

set -e
clear

if [ ! -d "~/.dillo" ]; then
	echo 'Dillo is not installed'
	echo "Can't find ~/.dillo folder"
	exit 1
fi

ROOTDIR=${GOPATH}/src/github.com/gotamer;
cd "${ROOTDIR}"

if [ ! -d "~/.dillo/dpi/gemini" ]; then
	echo '[INF] setting up for first run'
	go mod download github.com/boomlinde/gemini
	mkdir --parents ~/.dillo/dpi/gemini 
	mkdir --parents ~/.dillo/gemini

	echo { "autoPin": true } >> ~/.dillo/gemini/config.json
	echo proto.gemini=gemini/gemini.filter.dpi >> ~/.dillo/dpidrc
	echo '[INF] first run done!'
fi

fmt() {
	echo "[INF] FMT"
	cd "${ROOTDIR}"
	go fmt .
}

build() {
	fmt()
	wait
	echo "[INF] BUILDING"
	cd "${ROOTDIR}"
	go build .
	wait
	mv gemini.filter.dpi ~/.dillo/dpi/gemini/
}

$@
echo "[INF] all done"