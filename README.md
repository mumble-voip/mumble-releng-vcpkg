# mumble-releng-experimental

WARNING: This is Experimental and is not ready for use yet. Initial development is on-going.

The goal of this project is to prepare a compilation environment for Mumble.

Some dependencies are required for this tool to work.

The Mumble project dependencies (libraries being used) will for the most part be prepared (downloaded and compiled) by this tool.

We intend to provide workflows for setting up partial environments, for example to only compile the Mumble server software without the client, or with specific functionality not included.

`get-mumble_deps.sh` is currently a "proof of concept" designed to deliver vcpkg as a dependency framework for Mumble (client and server) and is likely to change. The long term goal is to automate dependency gathering for the client and server. As written, it should be capable of working on 64 bit Windows, GNU/Linux, and MacOSX. The vcpkg source and its requirements are found [here](https://github.com/Microsoft/vcpkg).

## Roadmap

* [ ] Initial script get-mumble_deps.sh
* [ ] Migrate Munmble to CMake ([mumble#3996](https://github.com/mumble-voip/mumble/issues/3996), WIP branch [cmake](https://github.com/davidebeatrici/mumble/tree/cmake))
* [x] Migrate ZeroC Ice project version 3.7 to CMake (upstream integration denied, forked to [mumble-voip/zeroc-ice](https://github.com/mumble-voip/ice), upstream upcoming undecided)

### Preparing Mumble dependencies

#### Windows

So far, this has been tested with MSVC which can be installed from Visual Studio Build Tools, or Visual Studio Community. Either can be downloaded [here](https://visualstudio.microsoft.com/downloads). Make sure to select the C++ build tools (or Development, respectively) and that the "C++ MFC for latest v14[X] build tools" is also checked. vcpkg also requires the English Language pack which is found in the Language packs section of the Visual Studio Installer.

The dependency download and build script requires [Git for Windows](https://git-scm.com/download/win). During installation, make sure the option to set Environment Variables is ticked. It is also suggested to add the Git install directory (i.e. `%ProgramFiles%\Git`) to the User PATH (or System PATH if a multi-user PC) if using cmd or PowerShell to run the script.

Click Start, search for Git Bash and run it. cd to the git repository directory and run the following command:

`./get-mumble_deps.sh`

#### GNU/Linux and MacOSX

Additional `dev` packages will need to be installed for some components in vcpkg on GNU/Linux:

* `libxi(X11)`
* `libgl1-mesa`
* `libglu1-mesa`
* `mesa-common`
* `libxrandr`
* `libxxf86vm`

vcpkg will also require installation of:

* `python3`
* `python2`
* `python`

Most GNU/Linux distros should have these or equivalent packages.

The following is required for MacOSX:

`Xquartz`

vcpkg recommends using `gcc` which can be installed using homebrew.

From a terminal cd to the cloned `mumble-releng-experimental` git repository, set execute permission (`chmod u+x get-mumble_deps.sh`), and run the following command:

`./get-mumble_deps.sh`

## Building Mumble

Now that the depdenencies have been prepared with CMake and vcpkg you can build the Mumble project with them.

Mumble (server and client) are built with CMake.

The Mumble project has not been migrated to CMake yet ([ticket #3996](https://github.com/mumble-voip/mumble/issues/3996)).[1] The WIP branch is available at [github.com/davidebeatrici/mumble/tree/cmake](https://github.com/davidebeatrici/mumble/tree/cmake).

In order for the FindIce module to work properly, `Ice_HOME` must be defined when running the configure step of CMake for the Mumble sources like so:

`cmake -G <preferred_generator> -DIce_HOME=~/vcpkg/installed/x64-windows-static-md -DVCPKG_TARGET_TRIPLET=x64-windows-static-md ...`

```bash
cd mumble
 ~/vcpkg/downloads/tools/cmake-3.14.0-windows/cmake-3.14.0-win32-x86/bin/cmake . -G <preferred_generator> -DIce_HOME=~/vcpkg/installed/x64-windows-static-md -DVCPKG_TARGET_TRIPLET=x64-windows-static-md -DCMAKE_TOOLCHAIN_FILE=~/vcpkg/scripts/buildsystems/vcpkg.cmake
 ```

## Technical Details

We use vcpkg to manage dependencies; to download, compile them and to include them in our own project build.

We use CMake as our build system and to include the dependencies. vcpkg uses and encourages CMake, and CMake is well established in the C++ project space.

### Forks of zeroc-ice and vcpkg for Ice 3.7 CMake

ZeroC Ice 3.7 is not a CMake project. We implemented it as a CMake project so we can integrate it in our CMake project. However, ZeroC does not want to integrate it into upstream 3.7. They are still undecided if they want to use CMake for future versions or a different build system.

As a result we have to [fork the zeroc-ice project](https://github.com/mumble-voip/ice) to integrate our CMake project of it. We also [fork vcpkg](https://github.com/mumble-voip/vcpkg) to integrate this zeroc-ice fork with vcpkg.
