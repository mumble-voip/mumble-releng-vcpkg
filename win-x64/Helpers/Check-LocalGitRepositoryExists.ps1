# Copyright 2018 The 'mumble-releng-experimental' Authors. All rights reserved.
# Use of this source code is governed by a BSD-style license that
# can be found in the LICENSE file in the source tree or at
# <http://mumble.info/mumble-releng-experimental/LICENSE>.

# Please refer to the following regarding commenting:
# <https://wiki.mumble.info/wiki/Coding_Guidelines#Comments>

# Please also refer to the following regarding function declaration:
# <https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_functions>

function Check-LocalGitRepositoryExists([Parameter(Mandatory=$true)][string] $Name,
										[Parameter(Mandatory=$true)][string] $RepoPath,
										[string] $Version) {

    if($version -eq $null) {
        $repositoryFolder = "$RepoPath/$Name"
    } else {
        $repositoryFolder = "$RepoPath/$Name-$Version"
    }

    $repositoryExists = $false
    if($repositoryFolder | Test-Path) {
        if((Get-Item -Path $repositoryFolder | measure).Count -gt 0) {
            $repositoryExists = $true
        }
    }
    return $repositoryExists
}