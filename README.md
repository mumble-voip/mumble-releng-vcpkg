# mumble-releng-vcpkg

The goal of this project is to prepare a compilation environment for Mumble.

Some dependencies are required for this tool to work. The dependencies are delivered using `vcpkg` for Windows, MacOS, and Linux and the source and its requirements are found [here](https://github.com/Microsoft/vcpkg).

The Mumble project dependencies (libraries being used) will for the most part be prepared (downloaded and compiled) by this tool.

We intend to provide workflows for setting up partial environments, for example to only compile the Mumble server software without the client, or with specific functionality not included.

The vcpkg source and its requirements are found [here](https://github.com/Microsoft/vcpkg).

## Roadmap

* [x] Initial script get-mumble_deps.sh
* [x] Migrate Mumble to CMake ([mumble#3996](https://github.com/mumble-voip/mumble/issues/3996), WIP branch [cmake](https://github.com/davidebeatrici/mumble/tree/cmake))
* [x] Migrate ZeroC Ice project version 3.7 to CMake (upstream integration denied, forked to [mumble-voip/zeroc-ice](https://github.com/mumble-voip/ice), upstream upcoming undecided)
* [x] Provide pre-built Windows environment as package
* [x] Create script for Windows

## Build environment setup

After the dependencies have been prepared with vcpkg and CMake you can build the Mumble project with them.

The setup is slightly different between Windows and Linux-based systems.

### Windows

You will need Git, Git Bash, CMake and MSVC.

If you want to create an installer you will also need the [WiX Toolset](https://wixtoolset.org/).

#### Git

The dependency download and build script requires [Git for Windows](https://git-scm.com/download/win). During installation, make sure the option to set Environment Variables is ticked. It is also suggested to add the Git install directory (i.e. `%ProgramFiles%\Git`) to the User `PATH` (or System `PATH` if a multi-user PC) environment variable if using cmd or PowerShell to run the script.

#### CMake (Windows)

Download and install the current version of [CMake](https://cmake.org/download/). If you want to use an existing installation of CMake make sure you use **version 3.15 or later**.

#### MSVC

MSVC (Microsoft Visual C++) is Microsoft’s C++ compiler toolchain. It can be installed from Visual Studio Build Tools, or Visual Studio Community. Either can be downloaded [here](https://visualstudio.microsoft.com/downloads).

Make sure to select the **C++ build tools** (or Development, respectively) and "**C++ MFC for latest v14[X] build tools**". vcpkg also requires the **English Language pack** which is found in the Language packs section of the Visual Studio Installer.

#### Preparing build dependencies (Windows)

Open a Powershell window as a regular user and issue the following command:

`Set-ExecutionPolicy -Scope CurrentUser RemoteSigned`

Move into this projects directory with the `cd` command. Run the following command:

`./Get-MumbleDeps.ps1`

### GNU/Linux and MacOSX

#### CMake (Linux/Mac)

Install CMake via your package manager (yum, apt, etc…). Make sure it is **version 3.15 or later**.

#### Build dependencies

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

#### Preparing build dependencies (Linux/Mac)

From a terminal cd to the cloned `mumble-releng-vcpkg` git repository, set execute permission (`chmod u+x get-mumble_deps.sh`), and run the following command:

`./get-mumble_deps.sh`

This will clone `vcpkg` and install the dependencies in the user's home directory. For Windows builds, if the vcpkg needs to be cloned elsewhere, make sure the path will allow for the maximum character limit for file paths in pre Windows 10 systems.

## Building Mumble

Mumble (server and client) are built with CMake since version 1.4.0.

### Command Line

1. Start a command line (On Windows a Developer Command Prompt for VS 2019)
2. Clone WIP cmake repo <https://github.com/davidebeatrici/mumble.git> (repository [davidebeatrici/mumble](https://github.com/davidebeatrici/mumble/tree/cmake))
3. Navigate into the folder
4. Checkout WIP cmake branch `cmake`
5. Create a directory named `build` and navigate into it (`mkdir build && cd build`)
6. Run the cmake generator with relative target path `..`
7. Run the cmake build with relative target path `..`

CMake will generate a bunch of files so you should call it from a dedicated, empty directory. Typically one folder per build configuration type is used (debug vs release, static, build configuration options etc). In the list above we suggest `build`.

#### CMake Generator

Important configuration options

| Option | Value | Description |
| --- | --- | --- |
| `VCPKG_TARGET_TRIPLET` | `x64-windows-static-md` or `x64-linux` or `x64-osx` | The vcpkg triplet of your build and built dependencies |
| `CMAKE_TOOLCHAIN_FILE` | `<vcpkg_root>/scripts/buildsystems/vcpkg.cmake` | |
| `Ice_HOME` | `<vcpkg_root>/installed/x64-windows-static-md` | Required if you build with Ice (enabled by default) |
| `static` | `ON` on Windows | Whether the build is a static build (otherwise dynamic) (environment default on Windows) |

If `<vcpkg_root>` is a placeholder for your prepared build environment vcpkg setup, then

for Linux the command may be

```bash
cmake -G "Ninja" "-DVCPKG_TARGET_TRIPLET=x64-linux" "-DCMAKE_TOOLCHAIN_FILE=<vcpkg_root>/scripts/buildsystems/vcpkg.cmake" "-DIce_HOME=<vcpkg_root>/installed/x64-windows-static-md" ..
```

for Windows the command may be

```bash
cmake -G "Ninja" "-DVCPKG_TARGET_TRIPLET=x64-windows-static-md" "-Dstatic=ON" "-DCMAKE_TOOLCHAIN_FILE=<vcpkg_root>/scripts/buildsystems/vcpkg.cmake" "-DIce_HOME=<vcpkg_root>/installed/x64-windows-static-md" ..
```

Additional Mumble project build configuration can be passed with `-D` defines. For the full list see the respective `CMakeLists.txt` files of the projects and subprojects. Some of the options include:

| Option Define                          | Default | Description |
| --- | --- | --- |
| `-DCMAKE_BUILD_TYPE=` | Release | Specify the build type multi-config (msbuild, etc...) |
| `-Dstatic=`                  | OFF | static linking of libraries (integrate) |
| `-Dsymbols=`                 | OFF | Build symbols |
| `-Dclient=`                  | ON | Build the client application |
| `-Dserver=`                  | ON | Build the server application |
| `-DBUILD_TESTING=`           | OFF | Build tests |
| `-Dpackaging=`               | OFF | Build installer |
| `-Doverlay=`                 | ON | Build the overlay feature |
| `-Dice=`                     | ON | Build with Ice feature |
| `-Dgrpc=`                    | OFF | Build with gRPC feature (experimental) |
| `-Djackaudio=`               | OFF | Build with jack feature |
| `-Dplugins=`                 | ON | Build positional audio plugins |

To build only the server you could use

```bash
cmake -G "NMake Makefiles" "-DVCPKG_TARGET_TRIPLET=x64-windows-static-md" "-Dstatic=ON" "-DCMAKE_TOOLCHAIN_FILE=<vcpkg_root>/scripts/buildsystems/vcpkg.cmake" "-DIce_HOME=<vcpkg_root>/installed/x64-windows-static-md" "-Dsymbols=ON" "-Dclient=OFF"
```

#### CMake Build

Once the project has completed configuration without errors, you can build it with

```bash
cmake --build ..
```

Depending on the generator you used you can also use the generated make files (e.g. by calling `nmake` or `ninja` or `msbuild`).

#### Create an installer

Currently, the installer creation has been tested on Windows.

An installer can be created after CMake-generating with `-Dpackaging=ON` and building.

To create a single-language installer (default English) run `cpack -C Release`.

To create a multi-language installer run the script `scripts/Create-Win32InstallerMUI.ps1`.

### Visual Studio (IDE)

[Visual Studio supports CMake projects](https://docs.microsoft.com/en-us/cpp/build/cmake-projects-in-visual-studio?view=vs-2019) when you install the *C++ CMake tools for Windows* in the Visual Studio Installer.

* Start Visual Studio
* Open the project folder (with the open folder option)
* In the CMake configuration settings specify the CMake toolchain file
  This file should be at `%USERPROFILE%/mumble-vcpkg/scripts/buildsystems/vcpkg.cmake` after using `get-mumble_deps.sh`.
* As CMake command argument add `-DVCPKG_TARGET_TRIPLET=x64-windows-static-md -Dstatic=ON -DIce_HOME=%USERPROFILE%/mumble-vcpkg/installed/x64-windows-static-md`
* Save and CMake should generate the build files, which will take a bit of time
* Use the build all action to build the project
* On success the built binaries will be placed in `out\build\<configuration-name>\`

Note: Visual Studio may wrongfully identify the error `The system was unable to find the specified registry key or value.` despite the build succeeding. This is due to a VS script that outputs `ERROR` as text early on in the build process. The queried registry key is not required for the build to succeed. Check the text Output or for other errors instead and **ignore this specific error**.

### Other IDEs with CMake support

IDE's such as Qt Creator, Visual Studio and VS Code (Code OSS) are capable of handling the configure and build step as part of the normal operation of the IDE. The options listed above are "Configure Arguments" and would need to be added for the project or workspace settings in the IDE when the source folder is opened as a CMake project.

## Technical Details

We use vcpkg to manage dependencies; to download, compile them and to include them in our own project build.

We use CMake as our build system and to include the dependencies. vcpkg uses and encourages CMake, and CMake is well established in the C++ project space.

### Forks of zeroc-ice and vcpkg for Ice 3.7 CMake

ZeroC Ice 3.7 is not a CMake project. We implemented it as a CMake project so we can integrate it in our CMake project. However, ZeroC does not want to integrate it into upstream 3.7. They are still undecided if they want to use CMake for future versions or a different build system.

As a result we have to [fork the zeroc-ice project](https://github.com/mumble-voip/ice) to integrate our CMake project of it. We also [fork vcpkg](https://github.com/mumble-voip/vcpkg) to integrate this zeroc-ice fork with vcpkg.
