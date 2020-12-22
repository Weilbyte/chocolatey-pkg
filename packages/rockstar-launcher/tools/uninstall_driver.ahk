; Drives through the RGS Launcher uninstaller. This is used because the installer does not allow silent uninstall.
WindowName = Rockstar Games Launcher Uninstall

WinWait, %WindowName%, , 10
if !ErrorLevel {
    Loop {
        Sleep 100
        ControlGet ctrlPresent, Visible,, Button6, %WindowName%
        If ctrlPresent
            Break
    }

    ControlSend, Button6, {Space}, %WindowName%

    Loop {
        Sleep 100
        ControlGet ctrlPresent, Visible,, Button4, %WindowName%
        If ctrlPresent
            Break
    }

    ControlSend, Button4, {Space}, %WindowName%
}