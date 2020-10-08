# mumble-releng-vcpkg

The goal of this project is to prepare a compilation environment for Mumble.

Some dependencies are required for this tool to work. The dependencies are delivered using `vcpkg` for Windows, MacOS, and Linux and the source and its requirements are found [here](https://github.com/Microsoft/vcpkg).

The Mumble project dependencies (libraries being used) will for the most part be prepared (downloaded and compiled) by this tool.

We intend to provide workflows for setting up partial environments, for example to only compile the Mumble server software without the client, or with specific functionality not included.

## Build environment setup

After the dependencies have been prepared with vcpkg and CMake you can build the Mumble project with them.

The setup is slightly different between Windows and Linux-based systems.

Note that the entire build environment will require about 30GB of disk space (on Windows). Moving the vcpkg-directory after it has been created and populated can also cause issue due to paths no longer being correct.

### Windows

You will need Git, CMake and MSVC.

If you want to create an installer you will also need the [WiX Toolset](https://wixtoolset.org/).

#### Git

The dependency download and build script requires [Git for Windows](https://git-scm.com/download/win). During installation, make sure the option to set Environment Variables is ticked. It is also suggested to add the Git install directory (i.e. `%ProgramFiles%\Git`) to the User `PATH` (or System `PATH` if a multi-user PC) environment variable if using cmd or PowerShell to run the script.

#### CMake (Windows)

Download and install the current version of [CMake](https://cmake.org/download/). If you want to use an existing installation of CMake make sure you use **version 3.15 or later**.

#### MSVC

MSVC (Microsoft Visual C++) is Microsoft’s C++ compiler toolchain. It can be installed from Visual Studio Build Tools, or Visual Studio Community. Either can be downloaded [here](https://visualstudio.microsoft.com/downloads) (Any somewhat recent version should work).

Make sure to select the **C++ build tools** (or Development, respectively) and "**C++ MFC for latest v14[X] build tools**" (just pick the latest version - e.g.`v142`). vcpkg also requires the **English Language pack** which is found in the Language packs section of the Visual Studio Installer.

#### Preparing build dependencies (Windows)

Open a Powershell window as a regular user and issue the following command:

`Set-ExecutionPolicy -Scope CurrentUser RemoteSigned`

Move into this projects directory with the `cd` command. Run the following command:

`./Get-MumbleDeps.ps1`

By default this will create a vcpkg directory in you user's directory (`C:\Users\<YourUserName>\mumble-vcpkg`). If you want this directory to be somewhere else, you have to modify `Get-MumbleDeps.ps1` and change the first lines accordingly.

### GNU/Linux and MacOSX

#### CMake (Linux/Mac)

Install CMake via your package manager (yum, apt, etc…). Make sure it is **version 3.15 or later**.

If your package manager doesn't provide a recent enough cmake version and you're on Ubuntu (or any of its derivatives, e.g. Linux Mint, Kubuntu, etc.) you can install cmake via a PPA. To do so, follow the instructions [here](https://apt.kitware.com/).

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

This will clone `vcpkg` and install the dependencies in the user's home directory. If you want to change the path, you have to edit `get-mumble_deps.sh` accordingly.

## Building Mumble

Mumble (server and client) are built with CMake since version 1.4.0.

### Command Line

1. Start a command line (on Windows see caveats listed below)
2. Clone the Mumble repo <https://github.com/mumble-voip/mumble.git>
3. Navigate into the folder
5. Create a directory named `build` and navigate into it (`mkdir build && cd build`)
6. Run the cmake generator with relative target path `..` (more on that further down)
7. Run the cmake in build-mode: `cmake --build .` or invoke your buildsystem of choice directly (e.g. `make -j $(nproc)`)

CMake will generate a bunch of files so you should call it from a dedicated, empty directory ("out-of-source build"). Typically one folder per build configuration type is used (debug vs release, static, build configuration options etc). In the list above we suggest `build`.

#### Windows caveats

On Windows you can't use the default command-prompt (as is) as it won't have the needed development tools in its PATH. Instead you have to use On Windows a "Developer Command Prompt". You can find it by searching in the start-menu. If you are on a 64bit system, then special care must be taken that you use a "x64" version of the Developer Prompt (often these are then called "x64 Native Tools Command Prompt"). The easiest way to get a hold of the correct command prompt is to search for "x64" and usually that is enough to bring the x64 developer prompt up.

Note also that you **have** to use the command prompt and **not** the Developer Powershell as the latter is always 32bit only.

If you are on a 64bit system, then you'll know that you have opened the correct prompt, if it prints `Environment initialized for: 'x64'`.

#### CMake Generator

Important configuration options

| Option | Value | Description |
| --- | --- | --- |
| `VCPKG_TARGET_TRIPLET` | `x64-windows-static-md` or `x64-linux` or `x64-osx` | The vcpkg triplet of your build and built dependencies |
| `CMAKE_TOOLCHAIN_FILE` | `<vcpkg_root>/scripts/buildsystems/vcpkg.cmake` | |
| `Ice_HOME` | `<vcpkg_root>/installed/x64-windows-static-md` | Required if you build with Ice (enabled by default) |
| `static` | `ON` on Windows | Whether the build is a static build (otherwise dynamic) (environment default on Windows) |

`<vcpkg_root>` is a placeholder for your prepared build environment vcpkg setup (the path to the vcpkg directory created by the get-dependency script).

For Linux the command may be (using the default generator `make`)

```bash
cmake "-DVCPKG_TARGET_TRIPLET=x64-linux" "-DCMAKE_TOOLCHAIN_FILE=<vcpkg_root>/scripts/buildsystems/vcpkg.cmake" "-DIce_HOME=<vcpkg_root>/installed/x64-linux" "-DCMAKE_BUILD_TYPE=Release" ..
```

For Windows the command may be

```bash
cmake -G "NMake Makefiles" "-DVCPKG_TARGET_TRIPLET=x64-windows-static-md" "-Dstatic=ON" "-DCMAKE_TOOLCHAIN_FILE=<vcpkg_root>/scripts/buildsystems/vcpkg.cmake" "-DIce_HOME=<vcpkg_root>/installed/x64-windows-static-md" "-DCMAKE_BUILD_TYPE=Release" ..
```

Optionally you can use `-G "Ninja"` to use the [Ninja buildsystem](https://ninja-build.org/) (which probably has to be installed separately). Especially on Windows this is recommended as the default `NMake Makefiles` only compile using a single thread (which takes quite a while).

Additional Mumble project build configuration can be passed with `-D` defines. For the full list see the output of `cmake -LH ..` (this also includes a lot of options from Mumble's dependencies like Qt and Opus) or use `cmake-gui`.

| Option Define                          | Default | Description |
| --- | --- | --- |
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
| `-Ddebug-dependency-search=` | OFF | Print extended information during the dependency search. Useful if some dependencies can't be found |

To build only the server you could use

```bash
cmake -G "NMake Makefiles" "-DVCPKG_TARGET_TRIPLET=x64-windows-static-md" "-Dstatic=ON" "-DCMAKE_TOOLCHAIN_FILE=<vcpkg_root>/scripts/buildsystems/vcpkg.cmake" "-DIce_HOME=<vcpkg_root>/installed/x64-windows-static-md" "-Dsymbols=ON" "-Dclient=OFF"
```

#### CMake Build

Once the project has completed configuration without errors, you can build it from the `build` directory with

```
cmake --build .
```

Windows builds can be done from a Developer Command prompt like this:

```
cmake --build . --config <build_type>
```

`<build_type>` can be specified as `Debug` or `Release`.

Depending on the generator you used you can also use the generated make files (e.g. by calling `nmake`, `make`, `ninja` or `msbuild`).

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

As a result we have to [fork the zeroc-ice project](https://github.com/mumble-voip/ice) to integrate our CMake project of it.


## Troubleshooting

### sndfile not found

This is an error that is often encountered on 64bit Windows systems. The problem is usually that you have used the wrong developer command prompt and therefore cmake is trying to build a 32bit version of Mumble. The `./Get-MumbleDeps.ps1` script automatically detects your system's architecture and only builds the 64bit version of the libraries (including `sndfile`). cmake then tries to locate a 32bit version of the library and fails as only the 64bit version is present.

The solution is to use a x64 developer command prompt. You can see what kind of build cmake is performing at the top of the cmake output. For 64 bit it should say `Architecture: 64bit`.

NOTE: If you initially have run cmake from the wrong prompt (32bit), then you'll have to delete all files in your `build` directory before running cmake again from the new prompt. Otherwise cmake will not check the architecture again and proceed with the cached 32bit variant.

### CMake can't find library

If cmake doesn't find a library and you don't really know why this might be, you can use `-Ddebug-dependency-search=ON` when running cmake in order to get a lot of debug information regarding the search for the needed dependencies. Chances are that this will shed some light on the topic.

### Unable to download from https://repo.msys2.org

This can happen if you're using a system that doesn't support TLS 1.3 (which https://repo.msys2.org requires) such as Windows 7. In this case the only possible workaround is either to download the respective files manually using a brower that does support TLS 1.3 (e.g. Firefox) or to replace all occurences of `https://repo.msys2.org` in the vcpkg dir with `http://repo.msys2.org` and thereby forxing vcpkg to use the HTTP mirror instead. Note though that this is inherently unsafer than using HTTPS.

A common error message for this scenario could be
```
-- Acquiring MSYS2...
-- Downloading https://sourceforge.net/projects/msys2/files/Base/x86_64/msys2-base-x86_64-20190524.tar.xz/download...
-- Downloading https://repo.msys2.org/msys/x86_64/msys2-keyring-r21.b39fb11-1-any.pkg.tar.xz...
-- Downloading https://repo.msys2.org/msys/x86_64/msys2-keyring-r21.b39fb11-1-any.pkg.tar.xz... Failed. Status: 35;"SSL connect error"
CMake Error at scripts/cmake/vcpkg_download_distfile.cmake:173 (message):

      Failed to download file.
      If you use a proxy, please set the HTTPS_PROXY and HTTP_PROXY environment
      variables to "https://user:password@your-proxy-ip-address:port/".
      Otherwise, please submit an issue at https://github.com/Microsoft/vcpkg/issue
```
Ref: https://github.com/microsoft/vcpkg/issues/13217
