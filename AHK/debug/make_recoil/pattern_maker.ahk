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

Pattern := Object()
Loop, Read, AEPattern/Havoc.txt
    Pattern[A_Index] := StrSplit(A_LoopReadLine, [A_Space, A_Tab])	

; mouse setting
global sens := 2
global modifier := 4/sens

; gun setting
global wpmaxt := 3.12																	
global cmodx := 0.37																
global cmody := 0.43
global lmax := Pattern.maxindex()																		
global interval := (wpmaxt/lmax)*1000	

; output setting
global out2txt := 1													
global outputfile := "pattern.txt"	

; advance
global rampx := 0	
global rampxstart := 80
global rampxend := 130
global rampxcmod := -20
global rampxcmodsub := rampxcmod - cmodx
global rampxstep := rampxcmodsub /(rampxend - rampxstart)

global rampy := 0
global rampystart := 100
global rampyend := lmax
global rampycmod := -5
global rampycmodsub := rampycmod - cmody
global rampystep := rampycmodsub /((rampyend - rampystart))

~$*LButton::
    if (!GetKeyState("RButton"))
        return

    FileDelete, %outputfile%

    Loop {
        fincmodx := cmodx
        if (rampx = 1) {
            if (a_index > rampxstart) AND (a_index < rampxend)
            {
                fincmodx += rampxstep
            }

            else { 
                if (a_index == rampxend) {
                    fincmodx := rampxcmod
                }
            }
        }

        fincmody := cmody
        if (rampy = 1) {
            if (a_index > rampystart) AND (a_index < rampyend)
            {
                fincmody += rampystep
            }

            else { 
                if (a_index == rampyend) {
                    fincmody := rampycmod
                }
            }
        }

        x := Round((Pattern[a_index+1][3]-Pattern[a_index][3])*fincmodx) 
        y := Round((Pattern[a_index+1][4]-Pattern[a_index][4])*fincmody)
        FileAppend, % Round(x) "," . Round(y) . "," . Round(interval, 1) . "`n", %outputfile%

        ToolTip % x " " y " " a_index

        DllCall("mouse_event", uint, 0x01, int, Round(x * modifier), int, Round(y * modifier))
        Sleep, interval

        if (!GetKeyState("LButton","P") || a_index > lmax) {
            DllCall("mouse_event", uint, 4, int, 0, int, 0, uint, 0, int, 0)
            break
        }
    }
return