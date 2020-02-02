#!/bin/bash

# Copyright 2020 The 'mumble-releng-experimental' Authors. All rights reserved.
# Use of this source code is governed by a BSD-style license that
# can be found in the LICENSE file in the source tree or at
# <http://mumble.info/mumble-releng-experimental/LICENSE>.

VCPKGDIR=${VCPKGDIR:-~/vcpkg}
VCPKG_INTEGRATE=${VCPKG_INTEGRATE:-1}
triplet=
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
            libvorbis, 
            libogg, 
            libflac, 
            sndfile, 
            libmariadb,
            zlib, 
            zeroc-ice'

if [ triplet == "" ]; then
    case "$OSTYPE" in
        msys* ) triplet='x64-windows-static-md';;
        linux-gnu* ) triplet='x64-linux';;
        darwin* ) triplet='x64-osx';;
        * )
            echo "The OSTYPE is either not defined or unsupported. Could not determine tripled. Aborting..."
            exit 1
            ;;
    esac
fi

function prepVcpkg {
    TARGET=$1
    INTEGRATE=${2:-0}
    if [ ! -d "$TARGET" ]; then
        git clone https://github.com/Microsoft/vcpkg.git $TARGET
        if [ ! $? -eq 0 ]; then
            echo "Failed to clone 'vcpkg'. Aborting..."
            return 1
        fi

        # vcpkg does not have a port for zeroc ice or mcpp, copy homegrown ports 
        cp -R helpers/vcpkg/ports/* $TARGET/ports/
        # copy custom triplet files
        cp helpers/vcpkg/triplets/* $TARGET/triplets/community

        pushd $TARGET
        case "$OSTYPE" in
            msys* )
                ./bootstrap-vcpkg.bat -disableMetrics
                if [ $INTEGRATE = 1 ]; then
                    ./vcpkg integrate install
                fi
                # install dns-sd provider
                ./vcpkg install mdnsresponder:$triplet
                ;;
            * )
                bash bootstrap-vcpkg.sh
                if [ $INTEGRATE = 1 ]; then
                    ./vcpkg integrate install
                fi
                ;;
        esac
        popd

        if [ ! $? -eq 0 ]; then
            echo "Failed to prepare 'vcpkg'. Aborting..."
            exit 1
        fi

        return 0
    fi
    echo Using existing vcpkg in $TARGET
    return 0
}

function prepDeps {
    pushd $VCPKGDIR

    if [ $VCPKG_INTEGRATE = 0 ]; then
        case "$OSTYPE" in
            msys* ) ./bootstrap-vcpkg.bat;;
            * ) bash bootstrap-vcpkg.sh;;
        esac
    fi

    if [ -z "$triplet" ]; then
        echo "Triplet type is not defined! Aborting..."
        return 1
    fi
    for dep in ${mumble_deps//,/ }
    do
        ./vcpkg install $dep:${triplet:?required triplet variable is not set}
        if [ ! $? -eq 0 ]; then
            popd
            echo "Failed to prepare dependency '$dep:$triplet'. Aborting..."
            exit 1
        fi
    done

    popd
    return 0
}

prepVcpkg $VCPKGDIR $VCPKG_INTEGRATE
if [ ! $? -eq 0 ]; then
    echo "Failed to prepare 'vcpkg'. Aborting..."
    exit 1
fi

prepDeps
