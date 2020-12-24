$ErrorActionPreference  = 'Stop'; 
$toolsDir               = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$pp                     = Get-PackageParameters

$url                    = 'https://gamedownloads.rockstargames.com/public/installer/Rockstar-Games-Launcher.exe' 
$checksum               =  '24B88BB60E78FDC6CD5DE46E29AA09A32670F5AD1400D7FF478A33759186B2BA'

. "$toolsDir/funcs.ps1"

if (!$pp['LANG']) { $pp['LANG'] = 'en-US' }
if (!$pp['DIR']) { $pp['DIR'] = 'C:\Program Files\Rockstar Games\Launcher'}

Get-ChocolateyWebFile -PackageName $env:ChocolateyPackageName -FileFullPath "$toolsDir\launcher.exe" -Url $url -Checksum $checksum -ChecksumType 'sha256'

Get-ChocolateyUnzip -FileFullPath "$toolsDir\launcher.exe" -Destination $pp['DIR']
Remove-Item "$($pp['DIR'])\`$PLUGINSDIR" -Recurse -ErrorAction Ignore
Remove-Item "$($pp['DIR'])\uninstall.exe.nsis" -Recurse -ErrorAction Ignore
Remove-Item "$toolsDir\launcher.exe" -ErrorAction Ignore

Start-Process "$($pp['DIR'])\Redistributables\VCRed\vc_redist.x64.exe" "/S" -ErrorAction Ignore


Remove-ARPEntry
Add-ARPEntry -Version $env:ChocolateyPackageVersion -InstallPath $pp['DIR']

Remove-LauncherRegistry
Add-LauncherRegistry -Version $env:ChocolateyPackageVersion -InstallPath $pp['DIR'] -Language $pp['LANG']

Add-Shortcuts -InstallPath $pp['DIR'] | Out-Null