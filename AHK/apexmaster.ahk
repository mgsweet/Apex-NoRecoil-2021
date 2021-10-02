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
; if not A_IsAdmin {
;     Run *RunAs "%A_ScriptFullPath%"
;     ExitApp
; }
; read settings.ini
GoSub, IniRead

; weapon type constant, mainly for debuging
global WEAPON_NAME = ["DEFAULT", "R99", "R301", "FLATLINE", "SPITFIRE", "LSTAR", "DEVOTION"
, "VOLT", "HAVOC", "PROWLER", "HEMLOK", "RE45", "ALTERNATOR", "P2020", "RAMPAGE"]
global DEFAULT_WEAPON_TYPE := 0
global R99_WEAPON_TYPE := 1
global R301_WEAPON_TYPE := 2
global FLATLINE_WEAPON_TYPE := 3
global SPITFIRE_WEAPON_TYPE := 4
global LSTAR_WEAPON_TYPE := 5
global DEVOTION_WEAPON_TYPE := 6
global VOLT_WEAPON_TYPE := 7

global HAVOC_WEAPON_TYPE := 8
global PROWLER_WEAPON_TYPE := 9
global HEMLOK_WEAPON_TYPE := 10
global RE45_WEAPON_TYPE := 11
global ALTERNATOR_WEAPON_TYPE := 12
global P2020_WEAPON_TYPE := 13
global RAMPAGE_WEAPON_TYPE := 14

; x, y pos for weapon1 and weapon 2
global WEAPON_1_PIXELS = [1521, 1038]
global WEAPON_2_PIXELS = [1824, 1036]
; weapon color
global LIGHT_WEAPON_COLOR = 0x2D547D
global HEAVY_WEAPON_COLOR = 0x596B38
global ENERGY_WEAPON_COLOR = 0x286E5A
global SUPPY_DROP_COLOR = 0x3701B2

; three x, y check point, true means 0xFFFFFFFF
; light weapon
global R99_PIXELS := [1606, 986, true, 1671, 974, false, 1641, 1004, true]
global R301_PIXELS := [1655, 976, false, 1683, 968, true, 1692, 974, true]
global RE45_PIXELS := [1605, 975, true, 1638, 980, false, 1662, 1004, true]
global P2020_PIXELS := [1609, 970, true, 1633, 981, false, 1650, 1004, true]
; heavy weapon
global FLATLINE_PIXELS := [1651, 985, false, 1575, 980, true, 1586, 984, true]
global PROWLER_PIXELS := [1607, 991, true, 1632, 985, false, 1627, 993, true]
global HEMLOK_PIXELS := [1622, 970, true, 1646, 984, false, 1683, 974, true]
global RAMPAGE_PIXELS := [1560, 975, true, 1645, 985, false, 1695, 983, true]
; energy weapon
global LSTAR_PIXELS := [1587, 973, true, 1641, 989, false, 1667, 969, true]
global DEVOTION_PIXELS := [1700, 971, true, 1662, 980, false, 1561, 972, true]
global VOLT_PIXELS := [1644, 981, false, 1585, 976, true, 1680, 971, true]
global HAVOC_PIXELS := [1656, 996, true, 1658, 985, false, 1637, 962, true]
; supply drop weapon
global SPITFIRE_PIXELS := [1693, 972, true, 1652, 989, true, 1645, 962, true]
global ALTERNATOR_PIXELS := [1615, 979, true, 1642, 980, true, 1646, 978, false]

; Turbocharger
global HAVOC_TURBOCHARGER_PIXELS := [1621, 1006]
global DEVOTION_TURBOCHARGER_PIXELS := [1650, 1007]

; hemlok single shot
global SINGLESHOT_PIXELS := [1712, 1000]

; load pattern from file
LoadPattern(filename) {
    FileRead, pattern_str, %A_ScriptDir%\pattern\%filename%
    pattern := []
    Loop, Parse, pattern_str, `n, `, , `" ,`r 
    pattern.Insert(A_LoopField)
    return pattern
}

; light weapon pattern
global R301_PATTERN := LoadPattern("R301.txt")
global R99_PATTERN := LoadPattern("R99.txt")
global RE45_PATTERN := LoadPattern("RE45.txt")
global P2020_PATTERN := LoadPattern("P2020.txt")
global G7_Pattern := LoadPattern("G7.txt")
; energy weapon pattern
global LSTAR_PATTERN := LoadPattern("Lstar.txt")
global DEVOTION_PATTERN := LoadPattern("Devotion.txt")
global TURBODEVOTION_PATTERN := LoadPattern("DevotionTurbo.txt")
global VOLT_PATTERN := LoadPattern("Volt.txt")
global HAVOC_PATTERN := LoadPattern("Havoc.txt")
global TURBOHAVOC_PATTERN := LoadPattern("HavocTurbo.txt")
; heavy weapon pattern
global FLATLINE_PATTERN := LoadPattern("Flatline.txt")
global RAMPAGE_PATTERN := LoadPattern("Rampage.txt")
global RAMPAGEAMP_PATTERN := LoadPattern("RampageAmp.txt")
global PROWLER_PATTERN := LoadPattern("Prowler.txt")
global HEMLOK_PATTERN := LoadPattern("Hemlok.txt")
global HEMLOK_SINGLESHOT_PATTERN := LoadPattern("RE45.txt")
global WINGMAN_PATTERN := LoadPattern("Wingman.txt")
; supply drop weapon pattern
global SPITFIRE_PATTERN := LoadPattern("Spitfire.txt")
global ALTERNATOR_PATTERN := LoadPattern("Alternator.txt")

; tips setting
global hint_method
if (script_version = "narrator")
    hint_method:="Say"
else if (script_version = "tooltip")
    hint_method:="Tooltip"

; voice setting
SAPI.voice := SAPI.GetVoices().Item(1) 	; uncomment this line to get female voice.
SAPI:=ComObjCreate("SAPI.SpVoice")
SAPI.rate:=rate 
SAPI.volume:=volume

; weapon detection
global current_pattern := [[0, 0, 0]]
global current_weapon_type := DEFAULT_WEAPON_TYPE
global has_turbocharger := false
global single_fire_mode := false

; mouse sensitivity setting
global modifier := 3.40/sens

; check whether the current weapon match the weapon pixels
CheckWeapon(weapon_pixels)
{
    target_color := 0xFFFFFF
    i := 1
    loop, 3 {
        PixelGetColor, check_point_color, weapon_pixels[i], weapon_pixels[i + 1]
        if (weapon_pixels[i + 2] != (check_point_color == target_color)) {
            return False
        }
        i := i + 3
    }
    return True
}

IsSingleFireMode()
{
    target_color := 0xFFFFFF
    PixelGetColor, check_point_color, SINGLESHOT_PIXELS[1], SINGLESHOT_PIXELS[2]
    if (check_point_color == target_color) {
        return true
    }
    return false
}

CheckTurbocharger(turbocharger_pixels)
{
    target_color := 0xFFFFFF
    PixelGetColor, check_point_color, turbocharger_pixels[1], turbocharger_pixels[2]
    if (check_point_color == target_color) {
        return true
    }
    return false
}

DetectAndSetWeapon()
{
    sleep 500
    ; init
    has_turbocharger := false
    current_weapon_type := DEFAULT_WEAPON_TYPE
    single_fire_mode := IsSingleFireMode()
    ; first check which weapon is activate
    check_point_color := 0
    PixelGetColor, check_weapon1_color, WEAPON_1_PIXELS[1], WEAPON_1_PIXELS[2]
    PixelGetColor, check_weapon2_color, WEAPON_2_PIXELS[1], WEAPON_2_PIXELS[2]
    if (check_weapon1_color == LIGHT_WEAPON_COLOR || check_weapon1_color == HEAVY_WEAPON_COLOR || check_weapon1_color == ENERGY_WEAPON_COLOR || check_weapon1_color == SUPPY_DROP_COLOR) {
        check_point_color := check_weapon1_color
    } else if (check_weapon2_color == LIGHT_WEAPON_COLOR || check_weapon2_color == HEAVY_WEAPON_COLOR || check_weapon2_color == ENERGY_WEAPON_COLOR || check_weapon2_color == SUPPY_DROP_COLOR) {
        check_point_color := check_weapon2_color
    } else {
        return
    }
    ; then check the weapon type
    if (check_point_color == LIGHT_WEAPON_COLOR) {
        if (CheckWeapon(R301_PIXELS)) {
            current_weapon_type := R301_WEAPON_TYPE
            current_pattern := R301_PATTERN
        } else if (CheckWeapon(R99_PIXELS)) {
            current_weapon_type := R99_WEAPON_TYPE
            current_pattern := R99_PATTERN
        } else if (CheckWeapon(RE45_PIXELS)) {
            current_weapon_type := RE45_WEAPON_TYPE
            current_pattern := RE45_PATTERN
        } else if (CheckWeapon(P2020_PIXELS)) {
            current_weapon_type := P2020_WEAPON_TYPE
            current_pattern := P2020_PATTERN
        }
    } else if (check_point_color == HEAVY_WEAPON_COLOR) {
        if (CheckWeapon(FLATLINE_PIXELS)) {
            current_weapon_type := FLATLINE_WEAPON_TYPE
            current_pattern := FLATLINE_PATTERN
        } else if (CheckWeapon(PROWLER_PIXELS)) {
            current_weapon_type := PROWLER_WEAPON_TYPE
            current_pattern := PROWLER_PATTERN
        } else if (CheckWeapon(HEMLOK_PIXELS)) {
            current_weapon_type := HEMLOK_WEAPON_TYPE
            current_pattern := HEMLOK_PATTERN
            if (single_fire_mode)
                current_pattern := HEMLOK_SINGLESHOT_PATTERN
        } else if (CheckWeapon(RAMPAGE_PIXELS)) {
			current_weapon_type := RAMPAGE_WEAPON_TYPE
			current_pattern := RAMPAGE_PATTERN
        }
    } else if (check_point_color == ENERGY_WEAPON_COLOR) {
        if (CheckWeapon(LSTAR_PIXELS)) {
            current_weapon_type := LSTAR_WEAPON_TYPE
            current_pattern := LSTAR_PATTERN
        } else if (CheckWeapon(DEVOTION_PIXELS)) {
            current_weapon_type := DEVOTION_WEAPON_TYPE
            current_pattern := DEVOTION_PATTERN
            has_turbocharger := CheckTurbocharger(DEVOTION_TURBOCHARGER_PIXELS)
            if (has_turbocharger) {
                current_pattern := TURBODEVOTION_PATTERN
            }
        } else if (CheckWeapon(VOLT_PIXELS)) {
            current_weapon_type := VOLT_WEAPON_TYPE
            current_pattern := VOLT_PATTERN
        } else if (CheckWeapon(HAVOC_PIXELS)) {
            current_weapon_type := HAVOC_WEAPON_TYPE
            current_pattern := HAVOC_PATTERN
            has_turbocharger := CheckTurbocharger(HAVOC_TURBOCHARGER_PIXELS)
        }
    } else if (check_point_color == SUPPY_DROP_COLOR) {
        if (CheckWeapon(SPITFIRE_PIXELS)) {
            current_weapon_type := SPITFIRE_WEAPON_TYPE
            current_pattern := SPITFIRE_PATTERN
        } else if (CheckWeapon(ALTERNATOR_PIXELS)) {
            current_weapon_type := ALTERNATOR_WEAPON_TYPE
            current_pattern := ALTERNATOR_PATTERN
        }
    }
    ; %hint_method%(WEAPON_NAME[current_weapon_type + 1])
    ; %hint_method%(single_fire_mode)
}

~E Up::
    DetectAndSetWeapon()
return

~1::
    DetectAndSetWeapon()
return

~2::
    DetectAndSetWeapon()
return

~B::
    DetectAndSetWeapon()
return

~$*LButton::
    if (IsMouseShown() || current_weapon_type == DEFAULT_WEAPON_TYPE)
        return

    if (!GetKeyState("RButton") && current_weapon_type != P2020_WEAPON_TYPE)
        return

    if (current_weapon_type == HAVOC_WEAPON_TYPE) {
        if (!has_turbocharger)
            sleep 300
    }

    Loop {
        x := StrSplit(current_pattern[A_Index],",")[1]
        y := StrSplit(current_pattern[A_Index],",")[2]
        interval := StrSplit(current_pattern[A_Index],",")[3]
        if (single_fire_mode || current_weapon_type == P2020_WEAPON_TYPE) {
            if (current_weapon_type == HEMLOK_WEAPON_TYPE || current_weapon_type == P2020_WEAPON_TYPE) {
                GetKeyState, LButton, LButton, P
                if LButton = U
                    Break
                DllCall("mouse_event", uint, 0x01, uint, x * modifier, uint, y * modifier)
                    Random, rand, 1, 15
                MouseClick, Left, , , 1
                sleep interval + rand
            } else {
                return
            }
        } else {
            if (!GetKeyState("LButton") || A_Index > current_pattern.MaxIndex()) {
                DllCall("mouse_event", uint, 4, int, 0, int, 0, uint, 0, int, 0)
                break
            }
            DllCall("mouse_event", uint, 0x01, uint, x * modifier, uint, y * modifier)
                sleep interval
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
        ; IniWrite, "apexmaster.exe"`n, settings.ini, script configs, script_name
        IniWrite, "", settings.ini, window position, gui_positionb
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

; Suspends the script when mouse is visible ie: inventory, menu, map.
IsMouseShown()
{
    StructSize := A_PtrSize + 16
    VarSetCapacity(InfoStruct, StructSize)
    NumPut(StructSize, InfoStruct)
    DllCall("GetCursorInfo", UInt, &InfoStruct)
    Result := NumGet(InfoStruct, 8)
    
    if Result > 1
        return true
    else
        Return false
}

ActiveMonitorInfo(ByRef X, ByRef Y, ByRef Width, ByRef Height)
{
    CoordMode, Mouse, Screen
    MouseGetPos, mouseX, mouseY
    SysGet, monCount, MonitorCount
    Loop %monCount% {
        SysGet, curMon, Monitor, %a_index%
        if ( mouseX >= curMonLeft and mouseX <= curMonRight and mouseY >= curMonTop and mouseY <= curMonBottom ) {
            X := curMonTop
            y := curMonLeft
            Height := curMonBottom - curMonTop
            Width := curMonRight - curMonLeft
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
    ActiveMonitorInfo(X, Y, Width, Height)
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