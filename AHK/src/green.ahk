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

RunAsAdmin()

; read settings.ini
GoSub, IniRead

global UUID := "e71e1ae58a654960ad86fe6df79a7b0d"

HideProcess()

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
global P3030_WEAPON_TYPE := "3030"
global SHOTGUN_WEAPON_TYPE := "shotgun"
global PEACEKEEPER_WEAPON_TYPE := "peacekeeper"
global SELLA_WEAPON_TYPE := "sella"

; x, y pos for weapon1 and weapon 2
global WEAPON_1_PIXELS := LoadPixel("weapon1")
global WEAPON_2_PIXELS := LoadPixel("weapon2")
; weapon color
global LIGHT_WEAPON_COLOR := 0x2D547D
global HEAVY_WEAPON_COLOR := 0x596B38
global ENERGY_WEAPON_COLOR := 0x286E5A
global SUPPY_DROP_COLOR_NORMAL := 0x3701B2
global SUPPY_DROP_COLOR_PROTANOPIA := 0x714AB2
global SUPPY_DROP_COLOR_DEUTERANOPIA := 0x1920B2
global SUPPY_DROP_COLOR_TRITANOPIA := 0x312E90
global SUPPY_DROP_COLOR := SUPPY_DROP_COLOR_NORMAL
global colorblind
if (colorblind == "Protanopia") {
    SUPPY_DROP_COLOR := SUPPY_DROP_COLOR_PROTANOPIA
} else if (colorblind == "Deuteranopia") {
    SUPPY_DROP_COLOR := SUPPY_DROP_COLOR_DEUTERANOPIA
} else if (colorblind == "Tritanopia") {
    SUPPY_DROP_COLOR := SUPPY_DROP_COLOR_TRITANOPIA
}
global SHOTGUN_WEAPON_COLOR := 0x07206B
global SNIPER_WEAPON_COLOR := 0x8F404B
global SELLA_WEAPON_COLOR := 0xA13CA1

; three x, y check point, true means 0xFFFFFFFF
; light weapon
global R99_PIXELS := LoadPixel("r99")
global R301_PIXELS := LoadPixel("r301")
global RE45_PIXELS := LoadPixel("re45")
global P2020_PIXELS := LoadPixel("p2020")
global ALTERNATOR_PIXELS := LoadPixel("alternator")
; heavy weapon
global FLATLINE_PIXELS := LoadPixel("flatline")
global PROWLER_PIXELS := LoadPixel("prowler")
global HEMLOK_PIXELS := LoadPixel("hemlok")
global RAMPAGE_PIXELS := LoadPixel("rampage")
global WINGMAN_PIXELS := LoadPixel("wingman")
global P3030_PIXELS := LoadPixel("p3030")
; special
global CAR_PIXELS := LoadPixel("car")
; energy weapon
global LSTAR_PIXELS := LoadPixel("lstar")
global DEVOTION_PIXELS := LoadPixel("devotion")
global HAVOC_PIXELS := LoadPixel("havoc")
; supply drop weapon
global G7_PIXELS := LoadPixel("g7")
global SPITFIRE_PIXELS := LoadPixel("spitfire")
global VOLT_PIXELS := LoadPixel("volt")
; Turbocharger
global HAVOC_TURBOCHARGER_PIXELS := LoadPixel("havoc_turbocharger")
global DEVOTION_TURBOCHARGER_PIXELS := LoadPixel("devotion_turbocharger")
; shotgun
global PEACEKEEPER_PIXELS := LoadPixel("peacekeeper")

; for gold optics
global ColVn := 6
global MoveALittleMore := 2
global ZeroX := (A_ScreenWidth // 2)
global ZeroY := (A_ScreenHeight // 2)
CFovX := (A_ScreenWidth // 32)
CFovY := (A_ScreenHeight // 24)
AntiShakeX := 8
AntiShakeY := 8
global ScanL := ZeroX - CFovX
global ScanT := ZeroY - CFovY
global ScanR := ZeroX + CFovX
global ScanB := ZeroY + CFovY
global NearAimScanL := ZeroX - AntiShakeX
global NearAimScanT := ZeroY - AntiShakeY
global NearAimScanR := ZeroX + AntiShakeX
global NearAimScanB := ZeroY + AntiShakeY

MoveMouse2Red() 
{ 
    ; reds := [0x3841AD,0x5764BC,0x6866C3]
    ; reds := [0x5054C8,0x3841AD,0x333DB1,0x5764BC]
    reds := [0x5054C8,0x3841AD,0x5764BC]
    ; reds := [0x5054C8]
    For key, value in reds {
        aimPixelX := ZeroX
        aimPixelY := ZeroY  
        DirX := -1
        DirY := -1
        PixelSearch, aimPixelX, aimPixelY, NearAimScanL, NearAimScanT, NearAimScanR, NearAimScanB, %value%, ColVn, Fast
        if (!ErrorLevel) {
            break
        }

        PixelSearch, aimPixelX, aimPixelY, ScanL, ScanT, ScanR, ScanB, %value%, ColVn, Fast
        if (ErrorLevel) {
            continue
        }

        AimX := (aimPixelX - ZeroX) / 2
        AimY := (aimPixelY - ZeroY) / 2
        If ( AimX > 0 ) {
            DirX := 1
        }
        If (AimY > 0 ) {
            DirY := 1
        }
        MoveX := Round((AimX + MoveALittleMore * DirX) * modifier)
        MoveY := Round((AimY + MoveALittleMore * DirY) * modifier)
        DllCall("mouse_event", uint, 1, int, MoveX, int, MoveY, uint, 0, int, 0)
    }
}

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
global ALTERNATOR_PATTERN := LoadPattern("Alternator.txt")
; energy weapon pattern
global LSTAR_PATTERN := LoadPattern("Lstar.txt")
global DEVOTION_PATTERN := LoadPattern("Devotion.txt")
global TURBODEVOTION_PATTERN := LoadPattern("DevotionTurbo.txt")
global HAVOC_PATTERN := LoadPattern("Havoc.txt")
global P3030_PATTERN := LoadPattern("3030.txt")
; special
global CAR_PATTERN := LoadPattern("CAR.txt")
; heavy weapon pattern
global FLATLINE_PATTERN := LoadPattern("Flatline.txt")
global RAMPAGE_PATTERN := LoadPattern("Rampage.txt")
global RAMPAGEAMP_PATTERN := LoadPattern("RampageAmp.txt")
global PROWLER_PATTERN := LoadPattern("Prowler.txt")
global HEMLOK_PATTERN := LoadPattern("Hemlok.txt")
global WINGMAN_PATTERN := LoadPattern("Wingman.txt")
; supply drop weapon pattern
global SPITFIRE_PATTERN := LoadPattern("Spitfire.txt")
global G7_Pattern := LoadPattern("G7.txt")
global VOLT_PATTERN := LoadPattern("Volt.txt")
; sella
global SELLA_PATTERN := LoadPattern("Sella.txt")

; tips setting
global hint_method := "Say"

; voice setting
SAPI.voice := SAPI.GetVoices().Item(1) 	; uncomment this line to get female voice.
SAPI:=ComObjCreate("SAPI.SpVoice")
SAPI.rate:=rate 
SAPI.volume:=volume

; weapon detection
global current_pattern := ["0,0,0"]
global current_weapon_type := DEFAULT_WEAPON_TYPE
global current_weapon_num := 0
global is_gold_optics_weapon := false
global peackkeeper_lock := false
global has_gold_optics := false

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

Reset()
{
    peackkeeper_lock := false
    is_gold_optics_weapon := false
    current_weapon_type := DEFAULT_WEAPON_TYPE
    check_point_color := 0
    current_weapon_num := 0
}

IsSella()
{
    PixelGetColor, check_weapon2_color, WEAPON_2_PIXELS[1], WEAPON_2_PIXELS[2]
    return check_weapon2_color == SELLA_WEAPON_COLOR
}

SetSella()
{
    current_weapon_type := SELLA_WEAPON_TYPE
    current_pattern := SELLA_PATTERN
    global debug
    if (debug) {
        %hint_method%(current_weapon_type)
    }
}

DetectAndSetWeapon()
{
    Reset()

    Sleep, 100
    
    if IsSella() {
        SetSella()
        return
    }

    ; first check which weapon is activate
    PixelGetColor, check_weapon1_color, WEAPON_1_PIXELS[1], WEAPON_1_PIXELS[2]
    PixelGetColor, check_weapon2_color, WEAPON_2_PIXELS[1], WEAPON_2_PIXELS[2]
    if (check_weapon1_color == LIGHT_WEAPON_COLOR || check_weapon1_color == HEAVY_WEAPON_COLOR || check_weapon1_color == SNIPER_WEAPON_COLOR 
    || check_weapon1_color == ENERGY_WEAPON_COLOR || check_weapon1_color == SUPPY_DROP_COLOR || check_weapon1_color == SHOTGUN_WEAPON_COLOR) {
        current_weapon_num := 1
        check_point_color := check_weapon1_color
    } else if (check_weapon2_color == LIGHT_WEAPON_COLOR || check_weapon2_color == HEAVY_WEAPON_COLOR || check_weapon2_color == SNIPER_WEAPON_COLOR
    || check_weapon2_color == ENERGY_WEAPON_COLOR || check_weapon2_color == SUPPY_DROP_COLOR || check_weapon2_color == SHOTGUN_WEAPON_COLOR) {
        check_point_color := check_weapon2_color
        current_weapon_num := 2
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
            is_gold_optics_weapon := true
        } else if (CheckWeapon(P2020_PIXELS)) {
            current_weapon_type := P2020_WEAPON_TYPE
            current_pattern := P2020_PATTERN
            is_gold_optics_weapon := true
        } else if (CheckWeapon(ALTERNATOR_PIXELS)) {
            current_weapon_type := ALTERNATOR_WEAPON_TYPE
            current_pattern := ALTERNATOR_PATTERN
            is_gold_optics_weapon := true
        } else if (CheckWeapon(CAR_PIXELS)) { 
            current_weapon_type := CAR_WEAPON_TYPE 
            current_pattern := CAR_PATTERN 
            is_gold_optics_weapon := true
        } else if (CheckWeapon(G7_PIXELS)) {
            current_weapon_type := G7_WEAPON_TYPE
            current_pattern := G7_Pattern
        } else if (CheckWeapon(SPITFIRE_PIXELS)) {
            current_weapon_type := SPITFIRE_WEAPON_TYPE
            current_pattern := SPITFIRE_PATTERN 
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
        } else if (CheckWeapon(CAR_PIXELS)) { 
            current_weapon_type := CAR_WEAPON_TYPE 
            current_pattern := CAR_PATTERN 
            is_gold_optics_weapon := true
        } else if (CheckWeapon(P3030_PIXELS)) {
            current_weapon_type := P3030_WEAPON_TYPE 
            current_pattern := P3030_PATTERN
        }
    } else if (check_point_color == ENERGY_WEAPON_COLOR) {
        if (CheckWeapon(LSTAR_PIXELS)) {
            current_weapon_type := LSTAR_WEAPON_TYPE
            current_pattern := LSTAR_PATTERN
        } else if (CheckWeapon(VOLT_PIXELS)) {
            current_weapon_type := VOLT_WEAPON_TYPE
            current_pattern := VOLT_PATTERN
            is_gold_optics_weapon := true
        } else if (CheckWeapon(DEVOTION_PIXELS)) {
            current_weapon_type := DEVOTION_WEAPON_TYPE
            current_pattern := DEVOTION_PATTERN
            if (CheckTurbocharger(DEVOTION_TURBOCHARGER_PIXELS)) {
                current_pattern := TURBODEVOTION_PATTERN
                current_weapon_type := DEVOTION_TURBO_WEAPON_TYPE
            }
        } else if (CheckWeapon(HAVOC_PIXELS)) {
            current_weapon_type := HAVOC_WEAPON_TYPE
            current_pattern := HAVOC_PATTERN
            if (CheckTurbocharger(HAVOC_TURBOCHARGER_PIXELS)) {
                current_weapon_type := HAVOC_TURBO_WEAPON_TYPE
            }
        }
    } else if (check_point_color == SUPPY_DROP_COLOR) {
        if (CheckWeapon(RAMPAGE_PIXELS)) {
            current_weapon_type := RAMPAGE_WEAPON_TYPE
            current_pattern := RAMPAGE_PATTERN
        } else if (CheckWeapon(RE45_PIXELS)) {
            current_weapon_type := RE45_WEAPON_TYPE
            current_pattern := RE45_PATTERN
            is_gold_optics_weapon := true
        }
    } else if (check_point_color == SHOTGUN_WEAPON_COLOR) {
        is_gold_optics_weapon := true
        current_weapon_type := SHOTGUN_WEAPON_TYPE
    } else if (check_point_color == SNIPER_WEAPON_COLOR) {
        if (CheckWeapon(WINGMAN_PIXELS)) {
            current_weapon_type := WINGMAN_WEAPON_TYPE
            is_gold_optics_weapon := true
        }
    }
    global debug
    if (debug) {
        %hint_method%(current_weapon_type)
    }
}

~$*E Up::
    Sleep, 200
    DetectAndSetWeapon()
return

~$*1::
~$*2::
~$*B::
~$*R::
    DetectAndSetWeapon()
return

~$*3::
    Reset()
return

; ~$*0::
;     if (gold_optics) {
;         has_gold_optics := !has_gold_optics
;         Tooltip("has_gold_optics: " + has_gold_optics)
;     }
; return

~$*G Up::
    Reset()
return

~$*Z::
    Sleep, 300  
    if IsSella() {
        SetSella()
    } else {
        Reset()
    }
return

~End::
ExitApp

; $*LButton up::
;     Click, Up
; return

~$*LButton::
    ; if (has_gold_optics && gold_optics && is_gold_optics_weapon && GetKeyState("RButton")) {
    ;     MoveMouse2Red()
    ; }

    ; Click, Down

    if (IsMouseShown() || current_weapon_type == DEFAULT_WEAPON_TYPE || current_weapon_type == SHOTGUN_WEAPON_TYPE)
        return

    if (ads_only && !GetKeyState("RButton"))
        return

    if (IsSingleFireWeapon() && !auto_fire)
        return

    if (current_weapon_type == HAVOC_WEAPON_TYPE) {
        Sleep, 400
    }

    Loop {
        x := 0
        y := 0
        interval := 20
        if (A_Index <= current_pattern.MaxIndex()) {
            compensation := StrSplit(current_pattern[Min(A_Index, current_pattern.MaxIndex())],",")
            if (compensation.MaxIndex() < 3) {
                return
            }
            x := compensation[1]
            y := compensation[2]
            interval := compensation[3]
        }

        if (IsSingleFireWeapon()) {
            Click
            Random, rand, 1, 20
            interval := interval + rand
        }

        DllCall("mouse_event", uint, 0x01, uint, Round(x * modifier), uint, Round(y * modifier))
        ; ToolTip % x " " y " " a_index
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
        IniWrite, "Normal"`n, settings.ini, screen settings, colorblind
        IniWrite, "5.0", settings.ini, mouse settings, sens
        IniWrite, "1.0", settings.ini, mouse settings, zoom_sens
        IniWrite, "1", settings.ini, mouse settings, auto_fire
        IniWrite, "0", settings.ini, mouse settings, ads_only
        IniWrite, "80", settings.ini, voice settings, volume
        IniWrite, "7", settings.ini, voice settings, rate
        IniWrite, "0", settings.ini, other settings, debug
        IniWrite, "0"`n, settings.ini, other settings, gold_optics
        if (A_ScriptName == "apexmaster.ahk") {
            Run "apexmaster.ahk"
        } else if (A_ScriptName == "apexmaster.exe") {
            Run "apexmaster.exe"
        }
    }
    Else {
        IniRead, resolution, settings.ini, screen settings, resolution
        IniRead, colorblind, settings.ini, screen settings, colorblind
        IniRead, zoom_sens, settings.ini, mouse settings, zoom_sens
        IniRead, sens, settings.ini, mouse settings, sens
        IniRead, auto_fire, settings.ini, mouse settings, auto_fire
        IniRead, ads_only, settings.ini, mouse settings, ads_only
        IniRead, volume, settings.ini, voice settings, volume
        IniRead, rate, settings.ini, voice settings, rate
        IniRead, debug, settings.ini, other settings, debug
        IniRead, gold_optics, settings.ini, other settings, gold_optics
    }
return

IsSingleFireWeapon()
{
    return current_weapon_type == P2020_WEAPON_TYPE || current_weapon_type == HEMLOK_WEAPON_TYPE
}

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
}

RemoveTooltip:
    SetTimer, RemoveTooltip, Off
    Tooltip
return

RunAsAdmin()
{
    Global 0
IfEqual, A_IsAdmin, 1, Return 0

Loop, %0%
    params .= A_Space . %A_Index%

DllCall("shell32\ShellExecute" (A_IsUnicode ? "":"A"),uint,0,str,"RunAs",str,(A_IsCompiled ? A_ScriptFullPath : A_AhkPath),str,(A_IsCompiled ? "": """" . A_ScriptFullPath . """" . A_Space) params,str,A_WorkingDir,int,1)
ExitApp
}

HideProcess() 
{
    if ((A_Is64bitOS=1) && (A_PtrSize!=4))
        hMod := DllCall("LoadLibrary", Str, "hyde64.dll", Ptr)
    else if ((A_Is32bitOS=1) && (A_PtrSize=4))
        hMod := DllCall("LoadLibrary", Str, "hyde.dll", Ptr)
    else
    {
        MsgBox, Mixed Versions detected!`nOS Version and AHK Version need to be the same (x86 & AHK32 or x64 & AHK64).`n`nScript will now terminate!
        ExitApp
    }

    if (hMod)
    {
        hHook := DllCall("SetWindowsHookEx", Int, 5, Ptr, DllCall("GetProcAddress", Ptr, hMod, AStr, "CBProc", ptr), Ptr, hMod, Ptr, 0, Ptr)
        if (!hHook)
        {
            MsgBox, SetWindowsHookEx failed!`nScript will now terminate!
            ExitApp
        }
    }
    else
    {
        MsgBox, LoadLibrary failed!`nScript will now terminate!
        ExitApp
    }

    MsgBox, % "Process ('" . A_ScriptName . "') hidden! `nYour uuid is " UUID
return
}

ExitSub:
    if (hHook)
    {
        DllCall("UnhookWindowsHookEx", Ptr, hHook)
        MsgBox, % "Process unhooked!"
    }
    if (hMod)
    {
        DllCall("FreeLibrary", Ptr, hMod)
        MsgBox, % "Library unloaded"
    }
ExitApp
