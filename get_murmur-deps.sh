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

if [ ! -d "../vcpkg" ]
   then 
      git clone https://github.com/Microsoft/vcpkg.git ../vcpkg
      if [ "$(ls -A ../vcpkg)" ] 
	     then
		    # vcpkg does not have a port for zeroc ice or mcpp, copy homegrown ports 
            cp -R helpers/vcpkg/ports/* ../vcpkg/ports/
            cd ../vcpkg
            case "$OSTYPE" in
               msys* ) ./bootstrap-vcpkg.bat;;
               * ) bash bootstrap-vcpkg.sh;;
            esac
            ./vcpkg integrate install
            if [ -z "$triplet" ]
			   then
			      echo "Triplet type is not defined! Aborting..."
			else
               ./vcpkg install qt5-base gRPC boost-atomic boost-function boost-optional \
                  --triplet $triplet
			fi
      else
         echo "Failed to retrieve the 'vcpkg' repository! Aborting..."
      fi
else
   echo "vcpkg repository exists! Use vcpkg binary to manage the repository. Aborting..."
fi
