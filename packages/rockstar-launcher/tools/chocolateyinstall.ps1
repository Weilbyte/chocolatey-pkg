$ErrorActionPreference = 'Stop'; 
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://gamedownloads.rockstargames.com/public/installer/Rockstar-Games-Launcher.exe' 

Start-Process 'AutoHotkey' "$toolsDir\driver.ahk"

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  fileType      = 'exe'
  url           = $url
  softwareName  = 'Rockstar Games Launcher'
  checksum      = '24B88BB60E78FDC6CD5DE46E29AA09A32670F5AD1400D7FF478A33759186B2BA'
  checksumType  = 'sha256'   
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs 
