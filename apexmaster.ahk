#NoEnv
SetWorkingDir %A_ScriptDir%
#SingleInstance force
#MaxThreadsBuffer on
SetTitleMatchMode, 2
;#IfWinActive r5apex.exe
SetBatchLines -1						;removes default 10ms delay between lines
#MaxHotkeysPerInterval 99000000
#HotkeyInterval 99000000
#KeyHistory 0
ListLines Off
SetKeyDelay, -1, -1
SetMouseDelay, -1
SetDefaultMouseSpeed, 0
SetWinDelay, -1
if not A_IsAdmin {
    Run *RunAs "%A_ScriptFullPath%"
    ExitApp
}
; read settings.ini
GoSub, IniRead

; weapon type constant
global WEAPON_NAME = ["Default", "R99", "R301", "FLATLINE", "SPITFIRE", "LSTAR", "DEVOTION"]
global DEFAULT_WEAPON_TYPE := 0
global R99_WEAPON_TYPE := 1
global R301_WEAPON_TYPE := 2
global FLATLINE_WEAPON_TYPE := 3
global SPITFIRE_WEAPON_TYPE := 4
global LSTAR_WEAPON_TYPE := 5
global DEVOTION_WEAPON_TYPE := 6
; current weapon type
global current_weapon_type := DEFAULT_WEAPON_TYPE
global current_weapon_num := 1

; x, y for weapon1 and weapon
global WEAPON_1_PIXELS = [1522, 1039]
global WEAPON_2_PIXELS = [1668, 1039]
; weapon coloar
global LIGHT_WEAPON_COLOR = 0x2D547D
global HEAVY_WEAPON_COLOR = 0x596B38
global ENERGY_WEAPON_COLOR = 0x286E5A

; three x, y check point, true means 0xFFFFFFFF
; light weapon
global R99_PIXELS := [1606, 986, true, 1671, 974, false, 1641, 1004, true]
global R301_PIXELS := [1655, 976, false, 1683, 968, true, 1692, 974, true]
; heavy weapon
global FLATLINE_PIXELS := [1651, 985, false, 1575, 980, true, 1586, 984, true]
global SPITFIRE_PIXELS := [1693, 972, true, 1652, 989, true, 1645, 962, true]
; energy weapon
global LSTAR_PIXELS := [1663, 968, true, 1576, 1001, true, 1641, 988, false]
global DEVOTION_PIXELS := [1700, 971, true, 1662, 980, false, 1561, 972, true]



; tips setting
if (script_version = "narrator")
    hint_method:="Say"
else if (script_version = "tooltip")
    hint_method:="Tooltip"


modifier:=2.50/sens
; voice setting
SAPI.voice := SAPI.GetVoices().Item(1) 	; uncomment this line to get female voice.
SAPI:=ComObjCreate("SAPI.SpVoice")
SAPI.rate:=rate 
SAPI.volume:=volume

global R99_INTERVAL := 55
global R99_RECOILS := [[-9, 11], [4, 11], [4, 11], [0, 14], [-9, 12]
                        , [-7, 15], [-10, 12], [4, 4], [10, 10], [4, 12]
                        , [6, 4], [3, 4], [-8, 6], [-4, 6], [-4, -2]
                        , [4, -5], [4, -5], [6, 0], [-2, 4], [-4, 4],
                        , [-6, 4], [-6, 4], [-6, 4], [-6, 4]]

global R301_INTERVAL := 72
global R301_RECOILS := [[-2, 12], [-2, 12], [-2, 12], [-2, 8], [0, 8]
                        , [-2, 5], [-2, 5], [-2, 3], [2, 3], [-4, 3]
                        , [4, 3], [4, 3], [4, 3], [4, 3], [4, 3]
                        , [4, 1], [4, 5], [2, 3], [-4, 3], [-2, 3]
                        , [-6, 1], [-6, 0], [-6, 0], [-6, 0], [-2, 0]
                        , [-2, 0], [-2, 0], [-2, 0], [-2, 0], [-2, 0]]

global LSTAR_INTERVAL := 100
global LSTAR_RECOILS := [[22, 12], [22, 12], [-16, 12], [-14, 12], [-14, 12]
                        , [-6, 10], [0, 10], [0, 10], [0, 10], [0, 10]
                        , [0, 10], [0, 10], [0, 10], [0, 10], [0, 10]
                        , [0, 10], [0, 10], [0, 10], [0, 10], [0, 10]]
                        ; , [-4, 10], [-4, 10], [-4, 10], [-4, 10], [-4, 10]
                        ; , [0, 10], [0, 10], [0, 10], [0, 10], [0, 10]
                        ; , [0, 10], [0, 10], [0, 10], [0, 10], [0, 10]]


; check whether the current weapon match the weapon pixels
check_weapon(WEAPON_pixels)
{
    target_color := 0xFFFFFF
    i := 1
    loop, 3 {
        PixelGetColor, check_point_color, WEAPON_pixels[i], WEAPON_pixels[i + 1]
        if (WEAPON_pixels[i + 2] != (check_point_color == target_color)) {
            ; MsgBox % WEAPON_pixels[i] " and " WEAPON_pixels[i + 1] " : " check_point_color " equal to " target_color "is not " WEAPON_pixels[i + 2]
            return False
        }
        i := i + 3
    }
    return True
}

detect_weapon(weapon_num)
{
    check_point_color := 0
    if (weapon_num == 1) {
        PixelGetColor, check_point_color, WEAPON_1_PIXELS[1], WEAPON_1_PIXELS[2]
    } else if (weapon_num == 2) {
        PixelGetColor, check_point_color, WEAPON_2_PIXELS[1], WEAPON_2_PIXELS[2]
    } else {
        return DEFAULT_WEAPON_TYPE
    }
    if (check_point_color == LIGHT_WEAPON_COLOR) {
        if (check_weapon(R301_PIXELS)) {
            return R301_WEAPON_TYPE
        } else if (check_weapon(R99_PIXELS)) {
            return R99_WEAPON_TYPE
        }
    } else if (check_point_color == HEAVY_WEAPON_COLOR) {
        if (check_weapon(FLATLINE_PIXELS)) {
            return FLATLINE_WEAPON_TYPE
        } else if (check_weapon(SPITFIRE_PIXELS)) {
            return SPITFIRE_WEAPON_TYPE
        }
    } else if (check_point_color == ENERGY_WEAPON_COLOR) {
        if (check_weapon(LSTAR_PIXELS)) {
            return LSTAR_WEAPON_TYPE
        } else if (check_weapon(DEVOTION_PIXELS)) {
            return DEVOTION_WEAPON_TYPE
        }
    }
    return DEFAULT_WEAPON_TYPE
}

~1::
    sleep 50
    current_weapon_num := 1
    current_weapon_type := detect_weapon(1)
    %hint_method%(WEAPON_NAME[current_weapon_type + 1])
return

~2::
    sleep 50
    current_weapon_num := 2
    current_weapon_type := detect_weapon(2)
    %hint_method%(WEAPON_NAME[current_weapon_type + 1])
return


~$*E::
    Loop {
        if (!GetKeyState("E")) {
            DllCall("mouse_event", uint, 4, int, 0, int, 0, uint, 0, int, 0)
            sleep 80
            current_weapon_type := detect_weapon(current_weapon_num)
            %hint_method%(WEAPON_NAME[current_weapon_type + 1])
            break
        }
    }

; isMouseShown()			; Suspends the script when mouse is visible ie: inventory, menu, map.
; {
;     StructSize := A_PtrSize + 16
;     VarSetCapacity(InfoStruct, StructSize)
;     NumPut(StructSize, InfoStruct)
;     DllCall("GetCursorInfo", UInt, &InfoStruct)
;     Result := NumGet(InfoStruct, 8)
    
;     if Result > 1
;         Return 1
;     else
;         Return 0
; }

; Loop {
;     if (isMouseShown() == 1) {
;         Suspend On
;     }else {
;         Suspend Off
;     }
;     Sleep 1
; }

~$*LButton::
    if (GetKeyState("RButton")) {
        ; interval := R99_INTERVAL
        ; i := 1
        ; recoils := R99_RECOILS
        i := 1
        if (current_weapon_type == R99_WEAPON_TYPE) {
            interval := R99_INTERVAL
            recoils := R99_RECOILS
        } else if (current_weapon_type == R301_WEAPON_TYPE) {
            interval := R301_INTERVAL
            recoils := R301_RECOILS
        } else if (current_weapon_type == LSTAR_WEAPON_TYPE) {
            interval := LSTAR_INTERVAL
            tooltip(interval)
            recoils := LSTAR_RECOILS
        } else {
            return
        }
        Loop
        {
            ; GetKeyState, LButton, LButton, P
            ; if LButton = U 
            ;     Break
            if (!GetKeyState("LButton") || i > recoils.Length()) {
                DllCall("mouse_event", uint, 4, int, 0, int, 0, uint, 0, int, 0)
                break
            }
            tooltip(recoils[i][1])
            sleep interval
            DllCall("mouse_event", uint, 0x01, uint, recoils[i][1] * modifier, uint, recoils[i][2] * modifier)
            i += 1
        }
    }
    return

; loop {
;     sleep, 10
;     if GetKeyState(key_1) {
;         current_weapon_num := 1
;         current_weapon_type = detect_weapon()
;         MsgBox % current_weapon_num
;     }
; }

; T::
; is_r99 := check_weapon(R99_PIXELS)
; is_r301 := check_weapon(R301_PIXELS)
; MsgBox %is_r99% and %is_r301%
; return

IniRead:
    IfNotExist, settings.ini
    {
        MsgBox, Couldn't find settings.ini. I'll create one for you.
        IniWrite, "5.0", settings.ini, mouse settings, sens
        IniWrite, "1.0"`n, settings.ini, mouse settings, zoom_sens
        IniWrite, "80", settings.ini, voice settings, volume
        IniWrite, "7"`n, settings.ini, voice settings, rate
        IniWrite, "narrator", settings.ini, script configs, script_version
        IniRead, script_name, settings.ini, script configs, script_name
        IniWrite, "apexmaster.ahk"`n, settings.ini, script configs, script_name
        IniWrite, "", settings.ini, window position, gui_position
        IniRead, script_name, settings.ini, script configs, script_name
        Run, %script_name%
    }
    Else {
        IniRead, sens, settings.ini, mouse settings, sens
        IniRead, zoom_sens, settings.ini, mouse settings, zoom_sens
        IniRead, volume, settings.ini, voice settings, volume
        IniRead, rate, settings.ini, voice settings, rate
        IniRead, script_version, settings.ini, script configs, script_version
    }
return

activeMonitorInfo(ByRef X, ByRef Y, ByRef Width, ByRef  Height)
{
    CoordMode, Mouse, Screen
    MouseGetPos, mouseX, mouseY
    SysGet, monCount, MonitorCount
    Loop %monCount%  {
        SysGet, curMon, Monitor, %a_index%
        if ( mouseX >= curMonLeft and mouseX <= curMonRight and mouseY >= curMonTop and mouseY <= curMonBottom ) {
            X      := curMonTop
            y      := curMonLeft
            Height := curMonBottom - curMonTop
            Width  := curMonRight  - curMonLeft
            return
        }
    }
}

Say(text)
{
    global SAPI
    SAPI.Speak(text, 1)
    sleep 150
    return
}

Tooltip(Text)
{
    activeMonitorInfo(X, Y, Width, Height)
    xPos := Width / 2 - 50
    yPos := Height / 2 + (Height / 10)
    Tooltip, %Text%, xPos, yPos
    SetTimer, RemoveTooltip, 500
    return
    RemoveTooltip:
        SetTimer, RemoveTooltip, Off
        Tooltip
    return
}
