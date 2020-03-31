#!/bin/bash

# Copyright 2020 The 'mumble-releng-experimental' Authors. All rights reserved.
# Use of this source code is governed by a BSD-style license that
# can be found in the LICENSE file in the source tree or at
# <http://mumble.info/mumble-releng-experimental/LICENSE>.

# On failed command (error code) exit the whole script
set -e
# Treat using unset variables as errors
set -u
# For piped commands on command failure fail entire pipe instead of only the last command being significant
set -o pipefail

VCPKGDIR=~/mumble-vcpkg

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
            poco,
            libvorbis, 
            libogg, 
            libflac, 
            sndfile, 
            libmariadb,
            zlib, 
            zeroc-ice'

# Determine vcpkg triplet from OS https://github.com/Microsoft/vcpkg/blob/master/docs/users/triplets.md
# Available triplets can be printed with `vcpkg help triplet`
case "$OSTYPE" in
    msys* ) triplet='x64-windows-static-md'
        xcompile_triplet='x86-windows-static-md';;
    linux-gnu* ) triplet='x64-linux';;
    darwin* ) triplet='x64-osx';;
    * ) echo "The OSTYPE is either not defined or unsupported. Aborting...";;
esac

if [ ! -d $VCPKGDIR ] 
    then 
        git clone https://github.com/mumble-voip/vcpkg.git $VCPKGDIR
fi

if [ -d $VCPKGDIR ] 
    then
        if [ ! -x $VCPKGDIR/vcpkg ]
            then
                cd $VCPKGDIR
                case "$OSTYPE" in
                    msys* ) ./bootstrap-vcpkg.bat -disableMetrics
                            ./vcpkg integrate install;;
                    * ) bash bootstrap-vcpkg.sh -disableMetrics
                        ./vcpkg integrate install;;
                esac
        fi

        if [ -z "$triplet" ]
            then
            echo "Triplet type is not defined! Aborting..."
        else
            cd $VCPKGDIR
            for dep in ${mumble_deps//,/ }
            do
                ./vcpkg install $dep:$triplet
            done

            case "$OSTYPE" in
                msys* )
                    # install dns-sd provider
                    ./vcpkg install mdnsresponder:$triplet
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
                ;;
            esac
        fi
else
    echo "Failed to retrieve the 'vcpkg' repository! Aborting..."
fi
