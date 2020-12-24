$ErrorActionPreference  = 'Stop'; 
$toolsDir               = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

. "$toolsDir/funcs.ps1"

Remove-Item (Get-UninstallRegistryKey -SoftwareName 'Rockstar Games Launcher').InstallLocation.Trim('"') -Recurse -ErrorAction Ignore
Remove-ARPEntry
Remove-LauncherRegistry

Remove-Item "C:\Users\$env:userName\Desktop\Rockstar Games Launcher.lnk" -Recurse -ErrorAction Ignore
Remove-Item "C:\Users\$env:userName\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Rockstar Games\Rockstar Games Launcher.lnk" -Recurse -ErrorAction Ignore
