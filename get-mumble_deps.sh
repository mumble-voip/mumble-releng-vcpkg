#!/bin/bash

# Copyright 2020 The 'mumble-releng-experimental' Authors. All rights reserved.
# Use of this source code is governed by a BSD-style license that
# can be found in the LICENSE file in the source tree or at
# <http://mumble.info/mumble-releng-experimental/LICENSE>.

mumble_deps='qt5-base, 
            qt5-svg, 
            qt5-tools, 
            grpc, 
            boost-accumulators, 
            boost-atomic, 
            boost-function, 
            boost-optional, 
            boost-system, 
            boost-thread, 
            opus,
            libvorbis, 
            libogg, 
            libflac, 
            sndfile, 
            libmariadb,
            zlib, 
            zeroc-ice'

case "$OSTYPE" in
    msys* ) triplet='x64-windows-static-md'
        xcompile_triplet='x86-windows-static-md';;
    linux-gnu* ) triplet='x64-linux'
        xcompile_triplet='x86-linux';;
    darwin* ) triplet='x64-osx';;
    * ) echo "The OSTYPE is either not defined or unsupported. Aborting...";;
esac

if [ ! -d ~/vcpkg ] 
    then 
        git clone https://github.com/Microsoft/vcpkg.git ~/vcpkg
fi

if [ -d ~/vcpkg ] 
    then
        if [ ! -x ~/vcpkg/vcpkg ]
            then
                # vcpkg does not have a port for zeroc ice or mcpp, copy homegrown ports 
                cp -R helpers/vcpkg/ports/* ~/vcpkg/ports/

                cd ~/vcpkg
                case "$OSTYPE" in
                    msys* ) ./bootstrap-vcpkg.bat -disableMetrics
                            ./vcpkg integrate install
                            # install dns-sd provider
                            ./vcpkg install mdnsresponder:$triplet;;
                    * ) bash bootstrap-vcpkg.sh -disableMetrics
                        ./vcpkg integrate install;;
                esac
        fi

        if [ -z "$triplet" ]
            then
            echo "Triplet type is not defined! Aborting..."
        else
            cd ~/vcpkg
            for dep in ${mumble_deps//,/ }
            do
                ./vcpkg install $dep:$triplet
            done

            boost_xcompile='boost-accumulators, 
                boost-atomic, 
                boost-function, 
                boost-optional, 
                boost-system, 
                boost-thread'
            for dep in ${boost_xcompile//,/ }
            do
                ./vcpkg install $dep:$xcompile_triplet
            done
        fi
else
    echo "Failed to retrieve the 'vcpkg' repository! Aborting..."
fi
