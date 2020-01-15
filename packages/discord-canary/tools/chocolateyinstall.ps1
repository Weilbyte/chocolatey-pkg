$ErrorActionPreference = 'Stop'; 
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://dl-canary.discordapp.net/apps/win/0.0.259/DiscordCanarySetup.exe' 

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  fileType      = 'exe' 
  url           = $url
  softwareName  = 'Discord Canary'
  checksum      = '475E7880E5103DFD38AB51EBE68ABE9C36233F940BBEA4507A5F7868A0EE1569'
  checksumType  = 'sha256'
  silentArgs   = '-s'           
  validExitCodes= @(0) 
}

Install-ChocolateyPackage @packageArgs 
