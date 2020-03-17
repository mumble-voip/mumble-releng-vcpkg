# mumble-releng-experimental

WARNING: This is Experimental and is not complete for use. Testing is on-going.

`get-mumble_deps.sh` is currently a "proof of concept" designed to deliver vcpkg as a dependency framework for Mumble (client and server) and is likely to change. The long term goal is to automate dependency gathering for the client and server. As written, it should be capable of working on 64 bit Windows, GNU/Linux, and MacOSX. The vcpkg source and its requirements are found [here](https://github.com/Microsoft/vcpkg).

## Windows

So far, this has been tested with MSVC which can be installed from Visual Studio Build Tools, or Visual Studio Community. Either can be downloaded [here](https://visualstudio.microsoft.com/downloads). Make sure to select the C++ build tools (or Development, respectively) and that the "C++ MFC for latest v14[X] build tools" is also checked. vcpkg also requires the English Language pack which is found in the Language packs section of the Visual Studio Installer.

The dependency download and build script requires [Git for Windows](https://git-scm.com/download/win). During installation, make sure the option to set Environment Variables is ticked. It is also suggested to add the Git install directory (i.e. `%ProgramFiles%\Git`) to the User PATH (or System PATH if a multi-user PC) if using cmd or PowerShell to run the script.

Click Start, search for Git Bash and run it. cd to the git repository directory and run the following command:

`./get-mumble_deps.sh`

## GNU/Linux and MacOSX

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

## Define Ice_HOME

In order for the FindIce module to work properly, `Ice_HOME` must be defined when running the configure step of CMake for the Mumble sources like so:

`cmake -G <preferred_generator> -DIce_HOME=~/vcpkg/installed/x64-windows-static-md -DVCPKG_TARGET_TRIPLET=x64-windows-static-md ...`

## Building Mumble

Mumble (server and client) are built with CMake.

The Mumble project has not been migrated to CMake yet ([ticket #3996](https://github.com/mumble-voip/mumble/issues/3996)).[1] The WIP branch is available at [github.com/davidebeatrici/mumble/tree/cmake](https://github.com/davidebeatrici/mumble/tree/cmake).
