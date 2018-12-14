#!/bin/bash

# Copyright 2018 The 'mumble-releng-experimental' Authors. All rights reserved.
# Use of this source code is governed by a BSD-style license that
# can be found in the LICENSE file in the source tree or at
# <http://mumble.info/mumble-releng-experimental/LICENSE>.

case "$OSTYPE" in
		msys* ) triplet='x64-windows-static';;
		linux-gnu* ) triplet='x64-linux';;
		darwin* ) triplet='x64-osx';;
		* ) echo "The OSTYPE is either not defined or unsupported. Aborting...";;
esac

if [ -d './vcpkg' ]
then
	git clone https://github.com/Microsoft/vcpkg.git

	if [ $? -eq 0 ]
	then
		cd vcpkg
		./bootstrap-vcpkg.bat
		[ -z "$triplet" ] && echo "Triplet type is not defined! Aborting..." || \
		./vcpkg install qt5-base gRPC boost-atomic boost-function boost-optional \
			--triplet $triplet
	else
		echo "Failed to retrieve the 'vcpkg' repository! Aborting..."
	fi
else
	echo "vcpkg directory exists. Use vcpkg binary to resolve issues with libraries"
fi