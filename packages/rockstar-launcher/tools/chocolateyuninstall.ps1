$ErrorActionPreference = 'Stop'; 
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  softwareName  = 'Rockstar Games Launcher'
  fileType      = 'exe'
  file          = (Get-UninstallRegistryKey -SoftwareName 'Rockstar Games Launcher').UninstallString.Trim('"')
  validExitCodes= @(0)
}

Start-Process 'AutoHotkey' "$toolsDir\uninstall_driver.ahk"

Uninstall-ChocolateyPackage @packageArgs