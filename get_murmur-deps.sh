#!/bin/bash

# Copyright 2018 The 'mumble-releng-experimental' Authors. All rights reserved.
# Use of this source code is governed by a BSD-style license that
# can be found in the LICENSE file in the source tree or at
# <http://mumble.info/mumble-releng-experimental/LICENSE>.

git clone https://github.com/Microsoft/vcpkg.git

if [ $? -eq 0 ]
then
	cd vcpkg
	./bootstrap-vcpkg.bat
	./vcpkg install qt5-base gRPC boost-atomic boost-function boost-optional \
		--triplet x64-windows-static
else
	echo "Failed to retrieve the 'vcpkg' repository! Aborting..."
fi