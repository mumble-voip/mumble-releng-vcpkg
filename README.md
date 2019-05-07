# mumble-releng-experimental

WARNING: This is Experimental and is not complete for use. Testing is on-going.

get-mumble_voip_deps.sh is currently a "proof of concept" designed to deliver vcpkg as a dependency framework for Mumble VoiP (client and server) and is likely to change. The long term goal is to automate dependency gathering for the client and server. As written, it should be capable of working on 64 bit Windows, GNU/Linux, and MacOSX. vcpkg source and requirements are found [here](https://github.com/Microsoft/vcpkg)

## Windows

Requires [Git for Windows](https://git-scm.com/download/win). During install, make sure the option to set Environment Variables is ticked. It is also suggested to add the Git install directory (i.e. %ProgramFiles%\Git) to User Path (or System Path if a multi-user PC) if using cmd or PowerShell to run the script. Directions can be found [here](https://www.addictivetips.com/windows-tips/set-path-environment-variables-in-windows-10/)

### Method 1

Click Start, search for Git Bash and run it. cd to the git repository directory and run the following command:

`./get-mumble_voip_deps.sh`

### Method 2

From cmd or PowerShell, cd to the git repository and run the following command:

`git-bash get-mumble_voip_deps.sh`

## GNU/Linux and MacOSX

From a terminal cd to the git repository, set execute permission, and run the following command:

`./get-mumble_voip_deps.sh`
