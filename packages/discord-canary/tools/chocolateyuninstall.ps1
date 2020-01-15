$ErrorActionPreference = 'Stop'; 
$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  softwareName  = 'Discord Canary' 
  fileType      = 'exe' 
  silentArgs   = '-s --uninstall'
  validExitCodes= @(0)
}

$uninstalled = $false
[array]$key = Get-UninstallRegistryKey -SoftwareName $packageArgs['softwareName']

if ($key.Count -eq 1) {
  $key | % { 
    $packageArgs['file'] = "$($_.UninstallString.TrimEnd('--uninstall'))"

    Uninstall-ChocolateyPackage @packageArgs

    $appdata = Split-Path (Split-Path (Split-Path $packageArgs['file']))
    Remove-Item "$appdata\Local\DiscordCanary" -Recurse -ErrorAction Ignore
    Remove-Item "$appdata\Roaming\discordcanary" -Recurse -ErrorAction Ignore
  }

} elseif ($key.Count -eq 0) {
  Write-Warning "$packageName has already been uninstalled by other means."
} elseif ($key.Count -gt 1) {
  Write-Warning "$($key.Count) matches found!"
  Write-Warning "To prevent accidental data loss, no programs will be uninstalled."
  Write-Warning "Please alert package maintainer the following keys were matched:"
  $key | % {Write-Warning "- $($_.DisplayName)"}
}

