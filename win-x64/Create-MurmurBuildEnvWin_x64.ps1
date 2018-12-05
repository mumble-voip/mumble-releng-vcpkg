# Copyright 2018 The 'mumble-releng-experimental' Authors. All rights reserved.
# Use of this source code is governed by a BSD-style license that
# can be found in the LICENSE file in the source tree or at
# <http://mumble.info/mumble-releng-experimental/LICENSE>.

# Please refer to the following regarding commenting:
# <https://wiki.mumble.info/wiki/Coding_Guidelines#Comments>

# Please also refer to the following regarding function declaration:
# <https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_functions>

param( 
    [ValidateScript( {
        if( -Not ($_ | Test-Path) ) {
            throw "Folder does not exist"
        }
        return $true
    })]
    [Parameter(Mandatory=$true)][System.IO.FileInfo] $Path
)

. "$PSScriptRoot/Helpers/Check-LocalGitRepositoryExists.ps1"
. "$PSScriptRoot/Helpers/Manage-LocalGitRepository.ps1"

# change repositories and versions here. use current release/stable tags,
# to fight regressions hopefully.

# zeroc ice
$iceRepository = "https://github.com/zeroc-ice/ice.git"
$iceReleaseVersion = "v3.7.1"

# microsoft vcpkg - does not have "releases", has a self contained "update"
$vcpkgRepository = "https://github.com/Microsoft/vcpkg.git"

$msbuildPath = "C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\`
    MSBuild\15.0\Bin\msbuild.exe"

$repositoryWarning = "Repository Exists!\n `
	It is recommended that you resolve repository contents manually using Git.\n`
    Aborting..."
        
if(Check-LocalGitRepositoryExists -name "ice" -version $iceReleaseVersion) {
    Write-Host $repositoryWarning
    exit    
} else {
    cd $Path
	Write-Host "Cloning Ice Repository..."
    Manage-LocalGitRepository -task "clone" -name "ice" -url $iceRepository `
        -branch $iceReleaseVersion
	cd "$Path/ice/cpp"
	Write-Host "Building Ice from source + NuGet dependencies..."
	$msbuildResult = (Start-Process  -FilePath "$msbuildPath/msbuild.exe" `
		-ArgumentList "/m msbuild\ice.proj /t:NuGetPack /p:Platform=x64" `
		-Wait -NoNewWindow -PassThru).ExitCode
	if ($msbuildResult -ne 0) {
		Write-Host "There was an error in the build process of Ice."
			"Aborting..."
			exit
	}
}

if(Check-LocalGitRepositoryExists -name "vcpkg") {
	Write-Host $repositoryWarning
	exit
} else {
	cd $Path
	Write-Host "Cloning Vcpkg Repository..."
	Manage-LocalGitRepository -task "clone" -name "vcpkg" -url $vcpkgRepository
	cd "$Path/vcpkg"
	Write-Host "Running Vcpkg Bootstrap script..."
	.\bootstrap-vcpkg.bat
}
