$ErrorActionPreference = 'Stop'; 
$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  softwareName  = 'Rainmeter'
  fileType      = 'exe'
  file          = (Get-UninstallRegistryKey -SoftwareName 'Rainmeter').UninstallString.Trim('"')
  silentArgs    = '/S'
  validExitCodes= @(0)
}

Uninstall-ChocolateyPackage @packageArgs

Remove-Item "$Env:Programfiles\Rainmeter" -Recurse -ErrorAction Ignore
Remove-Item "${env:ProgramFiles(x86)}\Rainmeter" -Recurse -ErrorAction Ignore