
# ARP
function Get-ARPRegistryPath {
    $knownPath = "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Rockstar Games Launcher"
    if (Test-Path $knownPath) {
        return $knownPath
    } else {
        foreach ($software in (Get-ChildItem -Path Registry::HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall)) {
            if ($software.getValue("DisplayName") -eq "Rockstar Games Launcher") {
                return "Registry::$software"
            }
        }
    }

    return $knownPath
}

function Remove-ARPEntry {
    Remove-Item $(Get-ARPRegistryPath) -ErrorAction Ignore
}

function Add-ARPEntry {
    param (
        [string]$version,
        [string]$installPath
    )
    $path = Get-ARPRegistryPath
    if (!(Test-Path $path)) {

        New-Item -Path $path | Out-Null
        New-ItemProperty -Path $path -Name "Comments" -Value "Rockstar Games Launcher" -PropertyType String -Force | Out-Null
        New-ItemProperty -Path $path -Name "DisplayIcon" -Value "$installPath\Launcher.exe" -PropertyType String -Force | Out-Null
        New-ItemProperty -Path $path -Name "DisplayName" -Value "Rockstar Games Launcher" -PropertyType String -Force | Out-Null
        New-ItemProperty -Path $path -Name "DisplayVersion" -Value $version -PropertyType String -Force | Out-Null
        New-ItemProperty -Path $path -Name "InstallLocation" -Value $installPath -PropertyType String -Force | Out-Null
        New-ItemProperty -Path $path -Name "Publisher" -Value "Rockstar Games" -PropertyType String -Force | Out-Null
    }
    
}

# Launcher registry
$launcherRegPath = "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Rockstar Games\Launcher"

function Remove-LauncherRegistry {
    Remove-Item $launcherRegPath -ErrorAction Ignore
}

function Add-LauncherRegistry {
    param (
        [string]$version,
        [string]$installPath,
        [string]$language = "en-US"
    )
    if (!(Test-Path $launcherRegPath)) {
        New-Item -Path $launcherRegPath -Force | Out-Null
        New-ItemProperty -Path $launcherRegPath -Name "InstallFolder" -Value $installPath -PropertyType String -Force | Out-Null
        New-ItemProperty -Path $launcherRegPath -Name "Language" -Value $language -PropertyType String -Force | Out-Null
        New-ItemProperty -Path $launcherRegPath -Name "Version" -Value $version -PropertyType String -Force | Out-Null
    }
}

# Shortcuts
function Add-Shortcuts {
    param (
        [string]$installPath
    )

    New-Item "C:\Users\$env:userName\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Rockstar Games" -ItemType Directory -Force
    $WshShell = New-Object -comObject WScript.Shell
    $Shortcut = $WshShell.CreateShortcut("C:\Users\$env:userName\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Rockstar Games\Rockstar Games Launcher.lnk")
    $Shortcut.TargetPath = "$installPath\LauncherPatcher.exe"
    $Shortcut.WorkingDirectory = $installPath
    $Shortcut.Save()

    $WshShell = New-Object -comObject WScript.Shell
    $Shortcut = $WshShell.CreateShortcut("C:\Users\$env:userName\Desktop\Rockstar Games Launcher.lnk")
    $Shortcut.TargetPath = "$installPath\LauncherPatcher.exe"
    $Shortcut.WorkingDirectory = $installPath
    $Shortcut.Save()
}