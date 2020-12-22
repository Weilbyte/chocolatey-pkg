; Drives through the RSG Launcher. This is used because the installer does not allow silent install.
WindowName = Rockstar Games Launcher

WinWait, %WindowName%, , 10
if !ErrorLevel {
    Loop {
        Sleep 100
        ControlGet ctrlPresent, Visible,, Button11, %WindowName%
        If ctrlPresent
            Break
    }

    ControlSend, Button5, {Space}, %WindowName%
    Sleep, 100
    ControlSend, Button6, {Space}, %WindowName%
    Sleep, 100
    ControlSend, Button6, {Space}, %WindowName%
    Sleep, 100
    ControlSend, Button6, {Space}, %WindowName%
 
    Loop {
        Sleep 100
        ControlGet ctrlPresent, Visible,, Button8, %WindowName%
        If ctrlPresent
            Break
    }

    ControlSend, Button8, {Space}, %WindowName%
    Sleep 50
    ControlSend, Button4, {Space}, %WindowName%
}