#NoEnv
#SingleInstance, Force
#Persistent
#InstallKeybdHook
#UseHook
#KeyHistory, 0
#HotKeyInterval 1
#MaxHotkeysPerInterval 127
SetKeyDelay,-1, 1
SetControlDelay, -1
SetMouseDelay, -1
SetWinDelay,-1
SendMode, InputThenPlay
SetBatchLines,-1
ListLines, Off
CoordMode, Mouse, Screen
PID := DllCall("GetCurrentProcessId")
Process, Priority, %PID%, High

EMCol := 0x3841AD,0x333DB1
ColVn := 8
AntiShakeX := 1
AntiShakeY := 1
ZeroX := (A_ScreenWidth // 2)
ZeroY := (A_ScreenHeight // 2)
CFovX := (A_ScreenWidth // 32)
CFovY := (A_ScreenHeight // 32)
ScanL := ZeroX - CFovX
ScanT := ZeroY - CFovY
ScanR := ZeroX + CFovX
ScanB := ZeroY + CFovY
NearAimScanL := ZeroX - AntiShakeX
NearAimScanT := ZeroY - AntiShakeY
NearAimScanR := ZeroX + AntiShakeX
NearAimScanB := ZeroY + AntiShakeY

Loop, {
    KeyWait, RButton, D
    PixelSearch, AimPixelX, AimPixelY, NearAimScanL, NearAimScanT, NearAimScanR, NearAimScanB, EMCol, ColVn, Fast
    ; If the collimator is already in the corresponding color attachment, do not move to avoid shaking
    if (ErrorLevel) {
        loop, 10 {
            PixelSearch, AimPixelX, AimPixelY, ScanL, ScanT, ScanR, ScanB, EMCol, ColVn, Fast
            AimX := AimPixelX - ZeroX
            AimY := AimPixelY - ZeroY
            DirX := -1
            DirY := -1
            If ( AimX > 0 ) {
                DirX := 1
            }
            If ( AimY > 0 ) {
                DirY := 1
            }
            AimOffsetX := AimX * DirX
            AimOffsetY := AimY * DirY
            MoveX := Floor(( AimOffsetX ** ( 1 / 2 ))) * DirX
            MoveY := Floor(( AimOffsetY ** ( 1 / 2 ))) * DirY
            DllCall("mouse_event", uint, 1, int, MoveX * 1.5, int, MoveY, uint, 0, int, 0)
            if (!GetKeyState("RButton","P")) {
                break
            }
        }
    }
}

~End::
ExitApp
return