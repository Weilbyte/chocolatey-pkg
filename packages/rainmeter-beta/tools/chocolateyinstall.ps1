$ErrorActionPreference = 'Stop'; 
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://github.com/rainmeter/rainmeter/releases/download/v4.4.0.3410/Rainmeter-4.4-r3410-beta.exe' 

Start-Process 'AutoHotkey' "$toolsDir\driver.ahk"

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  fileType      = 'exe' 
  url           = $url
  softwareName  = 'Rainmeter'
  checksum      = '9289364CC716204A0FE58362BF05A3698C1017CE69A608F0F7F62522E7365FBB'
  checksumType  = 'sha256'          
  validExitCodes= @(0) 
}

Install-ChocolateyPackage @packageArgs 
