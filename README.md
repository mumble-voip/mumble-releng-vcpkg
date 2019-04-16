# mumble-releng-experimental

WARNING: This is Experimental and is not complete for use. Testing is on-going.

get_mumur-deps.sh is currently a "proof of concept" designed to deliver vcpkg as a dependency framework for murmur (Mumble Server) and is likely to change. The long term goal is to automate dependency gathering for the client and server. As written, it should be capable of working on 64 bit Windows, GNU/Linux, and MacOSX. 

## Windows

Requires [Git for Windows](https://git-scm.com/download/win). During install, make sure the option to set Environment Variables is ticked. It is also necessary to add \Program Files\Git to User Path (or System Path if a multi-user PC) if using cmd or PowerShell to run the script. Directions can be found [here](https://www.addictivetips.com/windows-tips/set-path-environment-variables-in-windows-10/)

### Method 1

Click Start, search for Git Bash and run it. cd to the git repository directory and run the following command:

`./get_murmur-deps.sh`

### Method 2

From cmd or PowerShell, cd to the git repository and run the following command:

`git-bash get_murmur-deps.sh`

## GNU/Linux and MacOSX

From a terminal cd to the git repository and run the following command:

`./get_murmur-deps.sh`
