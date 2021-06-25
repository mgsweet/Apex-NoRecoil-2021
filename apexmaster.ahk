#NoEnv
SetWorkingDir %A_ScriptDir%
#SingleInstance force
#MaxThreadsBuffer on
SetTitleMatchMode, 2
;#IfWinActive r5apex.exe
SetBatchLines -1	
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

; weapon detect
global current_weapon_type := DEFAULT_WEAPON_TYPE
global has_turbocharger := false

; weapon type constant
global WEAPON_NAME = ["DEFAULT", "R99", "R301", "FLATLINE", "SPITFIRE", "LSTAR", "DEVOTION", "PROWLER", "HAVOC"]
global DEFAULT_WEAPON_TYPE := 0
global R99_WEAPON_TYPE := 1
global R301_WEAPON_TYPE := 2
global FLATLINE_WEAPON_TYPE := 3
global SPITFIRE_WEAPON_TYPE := 4
global LSTAR_WEAPON_TYPE := 5
global DEVOTION_WEAPON_TYPE := 6
global PROWLER_WEAPON_TYPE := 7
global HAVOC_WEAPON_TYPE := 8

; x, y for weapon1 and weapon
global WEAPON_1_PIXELS = [1521, 1038]
global WEAPON_2_PIXELS = [1824, 1036]
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
global PROWLER_PIXELS := [1644, 981, false, 1585, 976, true, 1680, 971, true]
global HAVOC_PIXELS := [1656, 996, true, 1658, 985, false, 1637, 962, true]
; Turbocharger
global HAVOC_TURBOCHARGER_PIXELS := [1621, 1006]
global DEVOTION_TURBOCHARGER_PIXELS := [1650, 1007]

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

; light weapon interval and recoils
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
; energy weapon interval and recoils
global LSTAR_INTERVAL := 100
global LSTAR_RECOILS := [[22, 12], [22, 12], [-16, 12], [-14, 12], [-14, 12]
                        , [-6, 10], [0, 10], [0, 10], [0, 10], [0, 10]
                        , [0, 10], [0, 10], [0, 10], [0, 10], [0, 10]
                        , [0, 10], [0, 10], [0, 10], [0, 10], [0, 10]]
global DEVOTION_INTERVAL := 100
global DEVOTION_RECOILS := [[0, 20], [0, 20], [-1, 20], [-1, 20], [-2, 20]
                        , [4, 20], [10, 6], [5, 6], [5, 6], [5, 6]
                        , [8, 6], [5, 6], [8, 4], [5, 4], [8, 4]
                        , [-10, 4], [-10, 4], [-10, 4], [-10, 4], [-10, 4]
                        , [0, 4], [0, 4], [0, 4], [-4, 4], [-4, 2]
                        , [-4, 2], [-4, 2], [-4, 2], [-4, 2], [-4, 2]
                        , [-4, 2], [-4, 2], [-4, 2], [-4, 2], [-4, 2]
                        , [-4, 2], [-4, 2], [-4, 2], [-4, 2], [-4, 2]
                        , [-4, 2], [-4, 2], [-4, 2], [-4, 2], [-4, 2]
                        , [-4, 2], [-4, 2], [-4, 2], [-4, 2], [-4, 2]]
global PROWLER_INTERVAL := 83
global PROWLER_RECOILS := [[-2, 16], [-2, 16], [-2, 16], [-2, 16], [-2, 10]
                        , [-2, 8], [-2, 6], [-4, 8], [4, 8], [6, 8]
                        , [8, 0], [8, 0], [8, 2], [8, 2], [-4, 4]
                        , [-4, 4], [-4, 4], [-4, 4], [4, 2], [4, 2]
                        , [4, 2], [4, 2] ,[0, 2] , [0, 2] , [0, 2]
                        ,[0, 2] , [0, 2] , [0, 2]]
global HAVOC_INTERVAL := 89
global HAVOC_RECOILS := [[-6, 10], [-6, 10], [-6, 12], [0, 12], [0, 12]
                        , [4, 10], [4, 10], [4, 10], [4, 10], [-4, 4]
                        , [-4, 2], [-4, 2], [-4, 2], [-4, 2], [-2, 4]
                        , [4, 4], [4, 4], [4, 4], [4, 4], [4, 4]
                        , [4, 4], [4, 4], [4, 6], [4, 6], [4, 6]
                        , [4, 6], [4, 6], [4, 6], [4, 6], [4, 6]
                        , [0, 6], [0, 6], [0, 6], [0, 6], [0, 6]
                        , [0, 6], [0, 6]]
; heavy weapon interval and recoils
global SPITFIRE_INTERVAL := 112
global SPITFIRE_RECOILS := [[2, 10], [2, 10], [4, 10], [4, 10], [4, 10]
                        , [4, 2], [-10, 2], [-10, 2], [-10, 2], [5, 2]
                        , [5, 2], [0, 2], [5, 2], [5, 2], [5, 2]
                        , [5, 2], [8, 4], [8, 4], [8, 4], [8, 4]
                        , [2, 4], [-4, 2], [-6, 2], [-6, 2], [-6, 2]
                        , [-6, 0], [-6, 2], [-6, 0], [-6, 0], [-6, 2]
                        , [0, 2], [0, 2], [0, 0], [0, 2], [0, 2]
                        , [4, 2], [4, 2], [4, 2], [4, 2], [4, 2]
                        , [4, 2], [4, 2], [2, 2], [2, 2], [2, 4]
                        , [2, 4], [-6, 4], [-6, 4], [-6, 4], [-6, 4]
                        , [0, 2], [0, 2], [0, 0], [0, 2], [0, 2]]
global FLATLINE_INTERVAL := 100
global FLATLINE_RECOILS := [[8, 12], [6, 12], [4, 10], [2, 8], [2, 8]
                        , [2, 8], [-3, 0], [-8, 0], [-8, 0], [-8, 2]
                        , [4, 4], [4, 4], [6, 2], [8, 6], [8, 6]
                        , [8, 6], [8, 6], [8, 2], [4, 2], [4, 2]
                        , [4, 2], [-4, 2], [-4, 2], [-4, 2], [-4, 2]
                        , [-4, 2], [-4, 2], [-4, 2], [-4, 2], [-4, 2]]


; check whether the current weapon match the weapon pixels
check_weapon(weapon_pixels) {
    target_color := 0xFFFFFF
    i := 1
    loop, 3 {
        PixelGetColor, check_point_color, weapon_pixels[i], weapon_pixels[i + 1]
        if (weapon_pixels[i + 2] != (check_point_color == target_color)) {
            ; MsgBox % weapon_pixels[i] " and " weapon_pixels[i + 1] " : " check_point_color " equal to " target_color "is not " weapon_pixels[i + 2]
            return False
        }
        i := i + 3
    }
    return True
}

check_turbocharger(turbocharger_pixels) {
    target_color := 0xFFFFFF
    PixelGetColor, check_point_color, turbocharger_pixels[1], turbocharger_pixels[2]
    if (check_point_color == target_color) {
        return true
    }
    return false
}

detect_weapon() {
    ; first check which weapon is activate
    check_point_color := 0
    PixelGetColor, check_weapon1_color, WEAPON_1_PIXELS[1], WEAPON_1_PIXELS[2]
    PixelGetColor, check_weapon2_color, WEAPON_2_PIXELS[1], WEAPON_2_PIXELS[2]
    if (check_weapon1_color == LIGHT_WEAPON_COLOR || check_weapon1_color == HEAVY_WEAPON_COLOR || check_weapon1_color == ENERGY_WEAPON_COLOR) {
        check_point_color := check_weapon1_color
    } else if (check_weapon2_color == LIGHT_WEAPON_COLOR || check_weapon2_color == HEAVY_WEAPON_COLOR || check_weapon2_color == ENERGY_WEAPON_COLOR) {
        check_point_color := check_weapon2_color
    } else {
        ToolTip(check_point_color " " check_weapon1_color " " check_weapon2_color)
        return DEFAULT_WEAPON_TYPE
    }
    ; then check the weapon type
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
        } else if (check_weapon(PROWLER_PIXELS)) {
            return PROWLER_WEAPON_TYPE
        } else if (check_weapon(HAVOC_PIXELS)) {
            return HAVOC_WEAPON_TYPE
        }
    }
    return DEFAULT_WEAPON_TYPE
}

detectAndSetWeapon() {
    sleep 50
    current_weapon_type := detect_weapon()
    ; set turbocharger
    if (current_weapon_type == DEVOTION_WEAPON_TYPE)
        has_turbocharger := check_turbocharger(DEVOTION_TURBOCHARGER_PIXELS)
    else if (current_weapon_type == HAVOC_WEAPON_TYPE)
        has_turbocharger := check_turbocharger(HAVOC_TURBOCHARGER_PIXELS)
    else 
        has_turbocharger := false
    global hint_method
    ; %hint_method%(WEAPON_NAME[current_weapon_type + 1])
    tooltip(has_turbocharger)
}

~E Up::
    detectAndSetWeapon()
return

~1::
    detectAndSetWeapon()
return

~2::
    detectAndSetWeapon()
return

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
        } else if (current_weapon_type == SPITFIRE_WEAPON_TYPE) {
            interval := SPITFIRE_INTERVAL
            recoils := SPITFIRE_RECOILS
        } else if (current_weapon_type == FLATLINE_WEAPON_TYPE) {
            interval := FLATLINE_INTERVAL
            recoils := FLATLINE_RECOILS
        } else if (current_weapon_type == LSTAR_WEAPON_TYPE) {
            interval := LSTAR_INTERVAL
            recoils := LSTAR_RECOILS
        } else if (current_weapon_type == PROWLER_WEAPON_TYPE) {
            interval := PROWLER_INTERVAL
            recoils := PROWLER_RECOILS
        } else if (current_weapon_type == HAVOC_WEAPON_TYPE) {
            interval := HAVOC_INTERVAL
            recoils := HAVOC_RECOILS
            if (!has_turbocharger) 
                sleep 300
        } else if (current_weapon_type == DEVOTION_WEAPON_TYPE) {
            interval := DEVOTION_INTERVAL
            recoils := DEVOTION_RECOILS
        } else {
            return
        }
        Loop
        {
            if (!GetKeyState("LButton") || i > recoils.Length()) {
                DllCall("mouse_event", uint, 4, int, 0, int, 0, uint, 0, int, 0)
                break
            }
            sleep interval
            DllCall("mouse_event", uint, 0x01, uint, recoils[i][1] * modifier, uint, recoils[i][2] * modifier)
            i += 1
        }
    }
    return

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

activeMonitorInfo(ByRef X, ByRef Y, ByRef Width, ByRef  Height) {
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

Say(text) {
    global SAPI
    SAPI.Speak(text, 1)
    sleep 150
    return
}

Tooltip(Text) {
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