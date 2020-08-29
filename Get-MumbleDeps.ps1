$profiledir = $Env:USERPROFILE 
$vcpkgdir = $profiledir + "\mumble-vcpkg"
$mumble_deps = "qt5-base",
			   "qt5-svg",
			   "qt5-tools",
			   "grpc",
			   "boost-accumulators",
			   "opus",
			   "poco",
			   "libvorbis",
			   "libogg",
			   "libflac",
			   "sndfile",
			   "libmariadb",
			   "zlib",
			   "zeroc-ice"

Write-Host "Setting triplets for $Env:PROCESSOR_ARCHITECTURE"
if ($Env:PROCESSOR_ARCHITECTURE -eq "AMD64") {
	$triplet = "x64-windows-static-md"
	$xcompile_triplet = "x86-windows-static-md"
} else {
	$triplet = "x86-windows-static-md"
}

Write-Host "Checking for $vcpkgdir..."
if (-not (Test-Path $vcpkgdir)) {
	git clone https://github.com/Microsoft/vcpkg.git $vcpkgdir
}

if (Test-Path $vcpkgdir) {
	Write-Host "Adding ports for ZeroC Ice..."
	Copy-Item -Path ./helpers/vcpkg/ports/zeroc-ice -Destination $vcpkgdir/ports -Recurse
	cd $vcpkgdir

	if (-not (Test-Path -LiteralPath $vcpkgdir/vcpkg.exe)) {
		Write-Host "Installing vcpkg..."
		./bootstrap-vcpkg.bat -disableMetrics
		./vcpkg.exe integrate install
	}

	./vcpkg.exe install mdnsresponder icu --triplet $triplet

	if ($Env:PROCESSOR_ARCHITECTURE -eq "AMD64") {
		Write-Host "Installing cross compile packages..."
		./vcpkg.exe install boost-optional:$xcompile_triplet --clean-after-build
	}

	Write-Host "Beginning package install..."

	foreach ($dep in $mumble_deps) {
		try {
			$ErrorActionPreference = 'Stop'
			./vcpkg.exe install $dep --triplet $triplet --clean-after-build
		}

		catch {
			Write-Warning "Package install failed for " $dep ": $_"
		}
	}
}

