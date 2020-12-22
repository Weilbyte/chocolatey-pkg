; Drives through the Rainmeter setup. This is used because the installer does not allow silent install.
WindowName = Rainmeter Setup

WinWait, %WindowName%, , 10
if !ErrorLevel {
    ControlSend, Button1, {Enter}, %WindowName%
    Sleep, 100
    ControlSend, Button2, {Enter}, %WindowName%
    Sleep, 100
    ControlSend, Button2, {Enter}, %WindowName%

    Loop {
    Sleep 100
    ControlGet ctrlPresent, Enabled,, Button2, %WindowName%
    If ctrlPresent
        Break
    }

    Sleep, 100
    ControlSend, Button4, {Space}, %WindowName%
    Sleep, 100
    ControlSend, Button2, {Enter}, %WindowName%
}