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

if not A_IsAdmin {
    Run *RunAs "%A_ScriptFullPath%"
    ExitApp
}
; read settings.ini
GoSub, IniRead

; weapon type constant, mainly for debuging
global DEFAULT_WEAPON_TYPE := "DEFAULT"
global R99_WEAPON_TYPE := "R99"
global R301_WEAPON_TYPE := "R301"
global FLATLINE_WEAPON_TYPE := "FLATLINE"
global SPITFIRE_WEAPON_TYPE := "SPITFIRE"
global LSTAR_WEAPON_TYPE := "LSTAR"
global DEVOTION_WEAPON_TYPE := "DEVOTION"
global DEVOTION_TURBO_WEAPON_TYPE := "DEVOTION TURBO"
global VOLT_WEAPON_TYPE := "VOLT"
global HAVOC_WEAPON_TYPE := "HAVOC"
global HAVOC_TURBO_WEAPON_TYPE := "HAVOC TURBO"
global PROWLER_WEAPON_TYPE := "PROWLER"
global HEMLOK_WEAPON_TYPE := "HEMLOK"
global RE45_WEAPON_TYPE := "RE45"
global ALTERNATOR_WEAPON_TYPE := "ALTERNATOR"
global P2020_WEAPON_TYPE := "P2020"
global RAMPAGE_WEAPON_TYPE := "RAMPAGE"
global WINGMAN_WEAPON_TYPE := "WINGMAN"
global G7_WEAPON_TYPE := "G7"
global CAR_WEAPON_TYPE := "CAR"

; x, y pos for weapon1 and weapon 2
global WEAPON_1_PIXELS = LoadPixel("weapon1")
global WEAPON_2_PIXELS = LoadPixel("weapon2")
; weapon color
global LIGHT_WEAPON_COLOR = 0x2D547D
global HEAVY_WEAPON_COLOR = 0x596B38
global ENERGY_WEAPON_COLOR = 0x286E5A
global SUPPY_DROP_COLOR = 0x3701B2

; three x, y check point, true means 0xFFFFFFFF
; light weapon
global R99_PIXELS := LoadPixel("r99")
global R301_PIXELS := LoadPixel("r301")
global RE45_PIXELS := LoadPixel("re45")
global P2020_PIXELS := LoadPixel("p2020")
; heavy weapon
global FLATLINE_PIXELS := LoadPixel("flatline")
global PROWLER_PIXELS := LoadPixel("prowler")
global HEMLOK_PIXELS := LoadPixel("hemlok")
global RAMPAGE_PIXELS := LoadPixel("rampage")
global WINGMAN_PIXELS := LoadPixel("wingman")
global CAR_PIXELS := LoadPixel("car")
; energy weapon
global LSTAR_PIXELS := LoadPixel("lstar")
global DEVOTION_PIXELS := LoadPixel("devotion")
global VOLT_PIXELS := LoadPixel("volt")
global HAVOC_PIXELS := LoadPixel("havoc")
; supply drop weapon
global SPITFIRE_PIXELS := LoadPixel("spitfire")
global ALTERNATOR_PIXELS := LoadPixel("alternator")
global G7_PIXELS := LoadPixel("g7")
; Turbocharger
global HAVOC_TURBOCHARGER_PIXELS := LoadPixel("havoc_turbocharger")
global DEVOTION_TURBOCHARGER_PIXELS := LoadPixel("devotion_turbocharger")

; each player can hold 2 weapons
LoadPixel(name) {
    global resolution
    IniRead, weapon_pixel_str, %A_ScriptDir%\resolution\%resolution%.ini, pixels, %name%
    weapon_num_pixels := []
    Loop, Parse, weapon_pixel_str, `,
    {
        if StrLen(A_LoopField) == 0 {
            Continue
        }
        weapon_num_pixels.Insert(A_LoopField)
    }
    return weapon_num_pixels
}

; load pattern from file
LoadPattern(filename) {
    FileRead, pattern_str, %A_ScriptDir%\pattern\%filename%
    pattern := []
    Loop, Parse, pattern_str, `n, `, , `" ,`r 
    {
        if StrLen(A_LoopField) == 0 {
            Continue
        }
        pattern.Insert(A_LoopField)
    }
    return pattern
}

; light weapon pattern
global R301_PATTERN := LoadPattern("R301.txt")
global R99_PATTERN := LoadPattern("R99.txt")
global RE45_PATTERN := LoadPattern("RE45.txt")
global P2020_PATTERN := LoadPattern("P2020.txt")
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
global WINGMAN_PATTERN := LoadPattern("Wingman.txt")
global CAR_PATTERN := LoadPattern("CAR.txt")
; supply drop weapon pattern
global SPITFIRE_PATTERN := LoadPattern("Spitfire.txt")
global ALTERNATOR_PATTERN := LoadPattern("Alternator.txt")
global G7_Pattern := LoadPattern("G7.txt")

; weapon detection
global current_pattern := ["0,0,0"]
global current_weapon_type := DEFAULT_WEAPON_TYPE
global is_single_fire_weapon := false

; mouse sensitivity setting
zoom := 1.0/zoom_sens
global modifier := 4/sens*zoom

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
    sleep 100
    ; init
    is_single_fire_weapon := false
    current_weapon_type := DEFAULT_WEAPON_TYPE
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
            is_single_fire_weapon := true
        } else if (CheckWeapon(CAR_PIXELS)) { 
            current_weapon_type := CAR_WEAPON_TYPE 
            current_pattern := CAR_PATTERN 
        }
    } else if (check_point_color == HEAVY_WEAPON_COLOR) {
        if (CheckWeapon(FLATLINE_PIXELS)) {
            current_weapon_type := FLATLINE_WEAPON_TYPE
            current_pattern := FLATLINE_PATTERN
        } else if (CheckWeapon(PROWLER_PIXELS)) {
            current_weapon_type := PROWLER_WEAPON_TYPE
            current_pattern := PROWLER_PATTERN
            is_single_fire_weapon := true
        } else if (CheckWeapon(HEMLOK_PIXELS)) {
            current_weapon_type := HEMLOK_WEAPON_TYPE
            current_pattern := HEMLOK_PATTERN
            is_single_fire_weapon := true
        } else if (CheckWeapon(RAMPAGE_PIXELS)) {
			current_weapon_type := RAMPAGE_WEAPON_TYPE
			current_pattern := RAMPAGE_PATTERN
        } else if (CheckWeapon(WINGMAN_PIXELS)) {
            current_weapon_type := WINGMAN_WEAPON_TYPE
            current_pattern := WINGMAN_PATTERN
            is_single_fire_weapon := true
        } else if (CheckWeapon(CAR_PIXELS)) { 
            current_weapon_type := CAR_WEAPON_TYPE 
            current_pattern := CAR_PATTERN 
        }
    } else if (check_point_color == ENERGY_WEAPON_COLOR) {
        if (CheckWeapon(LSTAR_PIXELS)) {
            current_weapon_type := LSTAR_WEAPON_TYPE
            current_pattern := LSTAR_PATTERN
        } else if (CheckWeapon(DEVOTION_PIXELS)) {
            current_weapon_type := DEVOTION_WEAPON_TYPE
            current_pattern := DEVOTION_PATTERN
            if (CheckTurbocharger(DEVOTION_TURBOCHARGER_PIXELS)) {
                current_pattern := TURBODEVOTION_PATTERN
                current_weapon_type := DEVOTION_TURBO_WEAPON_TYPE
            }
        } else if (CheckWeapon(VOLT_PIXELS)) {
            current_weapon_type := VOLT_WEAPON_TYPE
            current_pattern := VOLT_PATTERN
        } else if (CheckWeapon(HAVOC_PIXELS)) {
            current_weapon_type := HAVOC_WEAPON_TYPE
            current_pattern := HAVOC_PATTERN
            if (CheckTurbocharger(HAVOC_TURBOCHARGER_PIXELS)) {
                current_pattern := TURBOHAVOC_PATTERN
                current_weapon_type := HAVOC_TURBO_WEAPON_TYPE
            }
        }
    } else if (check_point_color == SUPPY_DROP_COLOR) {
        if (CheckWeapon(SPITFIRE_PIXELS)) {
            current_weapon_type := SPITFIRE_WEAPON_TYPE
            current_pattern := SPITFIRE_PATTERN
        } else if (CheckWeapon(ALTERNATOR_PIXELS)) {
            current_weapon_type := ALTERNATOR_WEAPON_TYPE
            current_pattern := ALTERNATOR_PATTERN
        } else if (CheckWeapon(G7_PIXELS)) {
            current_weapon_type := G7_WEAPON_TYPE
            current_pattern := G7_Pattern
            is_single_fire_weapon := true
        } 
    }
}

~E Up::
    Sleep, 200
    DetectAndSetWeapon()
return

~1::
~2::
~B::
~R::
~WheelUp::
~WheelDown::
    DetectAndSetWeapon()
return

~G::
~3::
~Z::
    current_weapon_type := DEFAULT_WEAPON_TYPE
return

~$*LButton::
    if (IsMouseShown() || current_weapon_type == DEFAULT_WEAPON_TYPE)
        return

    if (ads_only == "1" && !GetKeyState("RButton"))
        return

    if (is_single_fire_weapon && auto_fire != "1")
        return

    Loop {
        i := A_Index
        if (A_Index > current_pattern.MaxIndex()) {
            i := current_pattern.MaxIndex()
        }

        x := StrSplit(current_pattern[i],",")[1]
        y := StrSplit(current_pattern[i],",")[2]
        interval := StrSplit(current_pattern[i],",")[3]
        if (is_single_fire_weapon) {
            Click
            Random, rand, 1, 20
            interval := interval + rand
        }

        DllCall("mouse_event", uint, 0x01, uint, Round(x * modifier), uint, Round(y * modifier))
        Sleep, interval
        
        if (!GetKeyState("LButton","P")) {
            DllCall("mouse_event", uint, 4, int, 0, int, 0, uint, 0, int, 0)
            break
        }
    }
return

IniRead:
    IfNotExist, settings.ini
    {
        MsgBox, Couldn't find settings.ini. I'll create one for you.

        IniWrite, "1080x1920"`n, settings.ini, screen settings, resolution
        IniWrite, "5.0", settings.ini, mouse settings, sens
        IniWrite, "1.0", settings.ini, mouse settings, zoom_sens
        IniWrite, "1", settings.ini, mouse settings, auto_fire
        IniWrite, "0"`n, settings.ini, mouse settings, ads_only
        if (A_ScriptName == "apexmaster.ahk") {
            Run "apexmaster.ahk"
        } else if (A_ScriptName == "apexmaster.exe") {
            Run "apexmaster.exe"
        }
    }
    Else {
        IniRead, resolution, settings.ini, screen settings, resolution
        IniRead, sens, settings.ini, mouse settings, sens
        IniRead, zoom_sens, settings.ini, mouse settings, zoom_sens
        IniRead, auto_fire, settings.ini, mouse settings, auto_fire
        IniRead, ads_only, settings.ini, mouse settings, ads_only
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

~End::
    ExitApp
Return
