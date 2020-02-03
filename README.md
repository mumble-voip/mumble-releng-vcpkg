# mumble-releng-experimental

WARNING: This is Experimental and is not complete for use. Testing is on-going.

get-mumble_deps.sh is currently a "proof of concept" designed to deliver vcpkg as a dependency framework for Mumble (client and server) and is likely to change. The long term goal is to automate dependency gathering for the client and server. As written, it should be capable of working on 64 bit Windows, GNU/Linux, and MacOSX. vcpkg source and requirements are found [here](https://github.com/Microsoft/vcpkg)

## Windows

Requires [Git for Windows](https://git-scm.com/download/win). During install, make sure the option to set Environment Variables is ticked. It is also suggested to add the Git install directory (i.e. %ProgramFiles%\Git) to User Path (or System Path if a multi-user PC) if using cmd or PowerShell to run the script. 

Click Start, search for Git Bash and run it. cd to the git repository directory and run the following command:

`./get-mumble_deps.sh`

## GNU/Linux and MacOSX

Additional `dev` packages will need to be installed for some components in vcpkg on GNU/Linux:

`libxi(X11)`
`libgl1-mesa`
`libglu1-mesa`
`mesa-common`
`libxrandr`
`libxxf86vm`

vcpkg will also require installation of:

`python3`
`python2`
`python`

Most GNU/Linux distros should have these or equivalent packages.

The following is required for MacOSX:

`Xquartz`

From a terminal cd to the cloned `mumble-releng-experimental` git repository, set execute permission, and run the following command:

`./get-mumble_deps.sh`

## Define Ice_HOME

In order for the FindIce module to work properly, `Ice_HOME` must be defined when running the configure step of CMake for the Mumble sources like so:

`cmake -G <preferred_generator> -DIce_HOME=~/vcpkg/installed/x64-windows-static-md -DVCPKG_TARGET_TRIPLET=x64-windows-static-md ...`
