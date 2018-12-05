# Copyright 2018 The 'mumble-releng-experimental' Authors. All rights reserved.
# Use of this source code is governed by a BSD-style license that
# can be found in the LICENSE file in the source tree or at
# <http://mumble.info/mumble-releng-experimental/LICENSE>.

# Please refer to the following regarding commenting:
# <https://wiki.mumble.info/wiki/Coding_Guidelines#Comments>

# Please also refer to the following regarding function declaration:
# <https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_functions>

function Manage-LocalGitRepository([Parameter(Mandatory=$true)][string] $task, 
                                   [Parameter(Mandatory=$true)][string] $name, 
                                   [Parameter(Mandatory=$true)][string] $url, 
                                   [string] $branch) {

    if($branch -eq $null) {
        $gitResult = (Start-Process -FilePath "git.exe" -ArgumentList "$task $url" `
            -Wait -NoNewWindow -PassThru).ExitCode
    } else {
        $gitResult = (Start-Process -FilePath "git.exe" -ArgumentList "$task $url -b $branch" `
            -Wait -NoNewWindow -PassThru).ExitCode
    }
    if($gitResult -gt 0) {
        Write-Host "$task of $name repository failed! `
            Check the site or your internet. Aborting..."
    } else {
        Write-Host "$task of $name repository successful!"
    }
}