#NoEnv
#MaxHotkeysPerInterval 99000000
#HotkeyInterval 99000000
#KeyHistory 0
#SingleInstance force
#MaxThreadsBuffer on
#Persistent
Process, Priority, , A
SetBatchLines, -1
ListLines Off
SetWorkingDir %A_ScriptDir%
SetKeyDelay, -1, -1
SetMouseDelay, -1
SetDefaultMouseSpeed, 0
SetWinDelay, -1
SetControlDelay, -1
SendMode Input

; mouse setting
global sens := 2
global modifier := 4/sens
global x := 0
global y := 0

global interval := 17.4


~$*LButton::
    if (!GetKeyState("RButton"))
        return

    Loop {
        DllCall("mouse_event", uint, 0x01, int, Round(x * modifier), int, Round(y * modifier))
        Sleep, interval

        if (!GetKeyState("LButton","P")) {
            DllCall("mouse_event", uint, 4, int, 0, int, 0, uint, 0, int, 0)
            break
        }
    }
return