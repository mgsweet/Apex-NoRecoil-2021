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

; weapon type constant
global WEAPON_NAME = ["DEFAULT", "R99", "R301", "FLATLINE", "SPITFIRE", "LSTAR", "DEVOTION", "VOLT", "HAVOC", "PROWLER", "HEMLOK", "RE45", "ALTERNATOR", "P2020", "RAMPAGE", "R301ACOG", "FLATLINEACOG"]
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
global R301ACOG_WEAPON_TYPE := 15
global FLATLINEACOG_WEAPON_TYPE := 16

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
global R301ACOG_PIXELS := [1595, 1010, true, 1583, 1016, true, 1590, 1013, false]
global R301_PIXELS := [1655, 976, false, 1683, 968, true, 1692, 974, true]
global RE45_PIXELS := [1605, 975, true, 1638, 980, false, 1662, 1004, true]
global P2020_PIXELS := [1609, 970, true, 1633, 981, false, 1650, 1004, true]
; heavy weapon
global FLATLINEACOG_PIXELS := [1565, 1009, true, 1560, 1010, false, 1555, 1017, true]
global FLATLINE_PIXELS := [1651, 985, false, 1575, 980, true, 1586, 984, true]
global PROWLER_PIXELS := [1607, 991, true, 1632, 985, false, 1627, 993, true]
global HEMLOK_PIXELS := [1622, 970, true, 1646, 984, false, 1683, 974, true]
global RAMPAGE_PIXELS := [1709, 988, true, 1650, 992, false, 1630, 982, true]
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
 
; light weapon pattern
global R301_PATTERN :=  [[-3.5, 10.4, 80], [4.4, 10.6, 80], [-6.4, 9.5, 80], [-1.2, 10.0, 80], [-5.3, 7.6, 80]
, [-0.4, 4.1, 80], [-1.8, 3.3, 80], [-4.1, 1.9, 80], [-2.4, 3.3, 80], [-3.2, 1.0, 80]
, [0.0, 3.3, 80], [2.0, 2.2, 80], [5.0, 2.8, 80], [4.7, 2.3, 80], [5.0, 1.9, 80]
, [5.2, 0.9, 80], [3.2, 0.9, 80], [0.0, 2.2, 80], [-1.1, 4.2, 80], [-3.1, 2.8, 80]
, [-3.6, 1.3, 80], [-3.6, 0.0, 80], [-2.6, 1.4, 80], [-2.4, 1.4, 80], [-3.0, 0.0, 80]
, [0.0, 0.0, 80], [0.0, 0.0, 80], [0.0, 0.0, 80], [0.0, 0.0, 80], [0.0, 0.0, 80]]
global R301ACOG_PATTERN := [[0, 4, 80], [-6.8, 12.24, 80], [0.68, 17.0, 80], [-6.12, 8.16, 80], [-0.0, 14.96, 80]
, [-4.08, 3.5, 80], [3.36, 2.82, 80], [-0.0, 2.64, 80], [-4.12, 2.24, 80], [-3.8, 3.34, 80]
, [3.44, 3.44, 80], [3.4, 3.36, 80], [3.68, 2.9, 80], [4.52, 2.46, 80], [12.44, 2.78, 80]
, [3.12, 2.34, 80], [4.76, 2.7, 80], [2.0, 2.68, 80], [-1.1, 4.2, 80], [-3.1, 3.8, 80]
, [-3.6, -2.3, 80], [-3.6, 0.0, 80], [-2.6, 1.4, 80], [-2.4, 1.4, 80], [-3.0, 0.0, 80]
, [0.0, 0.0, 80], [0.0, 0.0, 80], [0.0, 0.0, 80], [0.0, 0.0, 80], [0.0, 0.0, 80]]
global R99_PATTERN := [[-1.6, 7, 53], [0.1, 7.5, 53], [2.3, 4.9, 53], [-1.8, 10, 53], [-3.3, 15.4, 53]
, [-6.3, 12, 53], [-5.5, 9.7, 53], [-2.5, 10.8, 53], [0.2, 11, 52], [2.3, 6.8, 52]
, [4.5, 5.3, 52], [0.9, 5.1, 52], [1.6, 9.5, 52], [-1.1, 4, 52], [-4.9, 1, 52]
, [-2.3, 1.8, 52], [-4.5, 0.5, 52], [4, 1.3, 52], [0, 0, 52], [2.5, 0.7, 52]
, [3.5, 0.7, 52], [4, 4, 52], [3.5, 0, 52], [4.6, 0, 52], [2, 0, 52]
, [2, 0, 52], [-5, -4, 52], [-5, 4, 52], [-5, -4, 52], [0, 4, 52]]
global RE45_PATTERN := [[-0.7, 12.6, 112], [-1.4, 10.9, 112], [-6.1, 11.2, 112], [-3.0, 11.6, 112], [-4.1, 9.9, 112]
, [-6.7, 8.0, 112], [-7.9, 7.1, 112], [-7.7, 6.9, 112], [-7.2, 6.2, 112], [-9.7, 5.0, 112]
, [-4.7, 5.1, 112], [0.0, 6.4, 112], [-5.7, 5.7, 112], [-3.4, 5.1, 112], [-2.4, 6.4, 112]
, [2.4, 5.7, 112], [-3.1, 4.7, 142], [0, 1.3, 142], [0, 3.4, 147], [0, 4.1, 147]
, [0, 2.4, 147], [0, 4.1, 147], [0, 0.0, 147]]
global P2020_PATTERN := [[2.4, 11, 130]]
; energy weapon pattern
global LSTAR_PATTERN := [[5, 5, 37], [5, 5, 37], [5, 5, 37], [5, 5, 37], [5, 5, 37]
, [5, 5, 37], [2, 5, 37], [2, 5, 37], [2, 5, 37], [1, 2, 37]
, [1, 2, 37], [-2, 2, 37], [-2, 2, 32], [-2, 2, 32], [-2, 5, 32]
, [-2, 5, 42], [-2, 5, 42], [-2, 5, 42], [-2, 5, 42], [-2, 5, 42]
, [-2, 5, 42], [-2, 5, 42], [-2, 5, 55], [-1, 5, 55], [-1, 5, 55]
, [-1, 5, 55], [-1, 5, 55], [-1, 5, 60], [-1, 5, 60], [-1, 5, 60]
, [-1, 5, 60], [-1, 5, 60], [-1, 5, 60], [1, 5, 65], [1, 5, 65]
, [1, 5, 65], [1, 5, 65], [1, 5, 65], [1, 5, 65], [0, 5, 65]
, [0, 5, 65], [0, 5, 65], [0, 5, 65], [0, 5, 65], [0, 5, 65]
, [0, 5, 65], [0, 5, 65], [0, 5, 65], [0, 5, 65], [0, 5, 65]
, [0, 5, 65], [0, 5, 65], [0, 5, 65], [0, 5, 65], [0, 5, 65]
, [0, 5, 65], [0, 5, 65], [0, 5, 65], [0, 5, 65], [0, 5, 65]]
global DEVOTION_PATTERN := [[0.0, 0.0, 40], [0.2, 24.5, 180], [0.3, 20.0, 170], [0.3, 23.5, 140], [0.6, 8.2, 120]
, [2.1, 4.5, 100], [2.8, 4.6, 85], [2.8, 7.6, 85], [6.2, 4.8, 85], [2.8, 3.4, 85]
, [3.1, 5.8, 68], [4.8, 3.1, 68], [3.0, 3.4, 68], [3.2, 2.3, 68], [7.6, 1.8, 68]
, [7.0, 0.5, 68], [4.2, -1.6, 68], [6.2, 1.6, 68], [-1.4, 2.6, 68], [0.0, 3.3, 66]
, [-3.9, 2.0, 66], [-4.5, 2.0, 66], [-4.5, 3.0, 66], [-6.7, 2.0, 66], [-7.0, 2.0, 66]
, [-3.1, 2.2, 66], [1.7, 3.7, 66], [-1.4, 3.8, 66], [-1.6, 3.0, 66], [-3.0, 2.5, 70]
, [-2.2, 2.1, 70], [-5.6, -0.5, 70], [-5.6, -0.5, 70], [-4.8, 2.7, 70], [-4.8, 2.7, 67]
, [-0.8, 3.1, 67], [-2.8, 2.5, 67], [2.0, 2.5, 67], [2.0, 2.5, 66], [-1.4, 3.7, 67]
, [-1.4, 2.8, 67], [-3.6, 1.6, 67], [-1.4, 2.3, 67], [0.0, 3.0, 67], [3.6, 1.8, 67]]
global TURBODEVOTION_PATTERN := [[0.0, 0.0, 40], [0.8, 24.5, 140], [0.3, 20.0, 140], [0.3, 23.5, 140], [2.0, 23.2, 100]
, [2.1, 7.5, 100], [2.0, 7.6, 100], [2.8, 5.6, 100], [6.2, 4.8, 100], [2.8, 3.4, 88]
, [3.1, 2.8, 88], [4.8, 2.1, 88], [5.0, 4.4, 88], [6.2, 2.3, 88], [7.6, 3.8, 86]
, [2.0, 0.5, 86], [-7, -1.6, 86], [-9, 1.6, 86], [-12.4, 4.6, 86], [-12, 5.3, 86]
, [-7.9, 3.9, 86], [-7.5, 2.3, 86], [-4.5, 2.5, 86], [-3.7, 3.0, 86], [-2.0, 3.0, 86]
, [9.1, 3.2, 86], [6.7, 3.7, 86], [6.4, 4.8, 86], [9.6, 2.4, 86], [9.0, 1.5, 88]
, [35.2, 2.1, 88], [35.6, -0.5, 88], [35.6, -0.5, 88], [35.8, 3.7, 88], [35.8, 3.7, 87]
, [25.8, 2.1, 87], [-2.8, 3.5, 87], [2.0, 3.5, 87], [2.0, 3.5, 86], [-1.4, 3.7, 86]
, [-1.4, 2.8, 86], [-3.6, 1.6, 86], [-1.4, 2.3, 86], [0.0, 3.0, 87], [0.0, 0.0, 120]]
global VOLT_PATTERN := [[0.0, 12.9, 81], [0.0, 9.5, 81], [-1.5, 11.3, 81], [-1.7, 9.4, 81], [-1.7, 11.1, 81]
, [-2.5, 13.1, 81], [-2.5, 9.7, 81], [-2, 9.8, 81], [-2.5, 9.2, 81], [-2.0, 6.6, 81]
, [1.0, 5.8, 81], [2.7, 1.2, 81], [4.0, 6.8, 81], [6.0, 4, 81], [5.0, 3.0, 81]
, [5.0, 3.3, 81], [0.0, 1.2, 81], [-2.0, 1.8, 81], [-2.0, 1.7, 81], [-2.0, 5.3, 81]
, [3.0, 0, 81], [1, 0.0, 81], [1, 7.0, 81], [1, 0.0, 81], [1, 0.0, 81]
, [1, 0.0, 81], [1, 0.0, 81]]
global HAVOC_PATTERN := [[-6, 10, 89], [-6, 10, 89], [-6, 12, 89], [0, 12, 89], [0, 12, 89]
, [4, 10, 89], [4, 10, 89], [4, 10, 89], [4, 10, 89], [-4, 4, 89]
, [-4, 2, 89], [-4, 2, 89], [-4, 2, 89], [-4, 2, 89], [-2, 4, 89]
, [4, 4, 89], [4, 4, 89], [4, 4, 89], [4, 4, 89], [4, 4, 89]
, [4, 4, 89], [4, 4, 89], [4, 6, 89], [4, 6, 89], [4, 6, 89]
, [4, 6, 89], [4, 6, 89], [4, 6, 89], [4, 6, 89], [4, 6, 89]
, [0, 6, 89], [0, 6, 89], [0, 6, 89], [0, 6, 89], [0, 6, 89]
, [0, 6, 89], [0, 6, 89]]
; heavy weapon pattern
global FLATLINE_PATTERN := [[4.0, 17.2, 110], [3.3, 8.3, 110], [6.3, 10.1, 110], [6.3, 7.5, 110], [3.3, 11.0, 110]
, [-1.3, 11.7, 110], [-4.5, 2.6, 110], [-10.6, -2.0, 110], [-2.7, 4.2, 110], [-3.9, 4.5, 110]
, [-1.7, 6.6, 110], [4.5, 5.0, 110], [9.9, 6.4, 110], [5.1, 7.9, 110], [9.6, -1.6, 110]
, [4.2, 2.1, 110], [1.8, 8.3, 110], [3.3, 8.1, 110], [6.9, 4.9, 110], [9.0, 2.3, 110]
, [3.9, 0.6, 113], [-1.2, 5, 113], [-7.9, 2.5, 113], [-5.5, 2, 113], [-8.8, 2.2, 113]
, [-9.1, 1.5, 113], [-8.8, 1, 113], [0, 0, 113], [0, 0, 113], [0, 0, 113]]
global FLATLINEACOG_PATTERN := [[0, 0, 111], [1.74, 17.0, 111], [9.86, 12.94, 111], [7.82, 9.52, 111], [5.0, 11.56, 111]
, [-0.68, 8.84, 111], [-2.04, 3.06, 111], [-7.82, -4.42, 111], [-4.76, -0.68, 111], [-5.78, 4.76, 111]
, [-4.06, 8.5, 111], [6.44, 3.74, 111], [13.6, 6.12, 111], [8.84, 3.74, 111], [12.24, -3.72, 111]
, [8.84, 3.76, 111], [8.02, 7.82, 111], [-2.1, 5.52, 111], [-1.04, 5.48, 111], [-10.84, 3.7, 111]
, [4.76, 2.7, 111], [-5.42, 3.4, 111], [-8.16, 1.04, 111], [-9.06, 2.72, 111], [-13.12, 1.76, 111]
, [-10.58, -1.02, 111], [-10.42, -2.4, 111], [-12.8, 0.0, 113]]
global RAMPAGE_PATTERN := [[5.07, 6.7, 200], [2.8, 5.2, 200], [-2.7,6.6, 200], [-2.7, 10.8, 200], [-2.5, 8.3, 200]
, [-2.3, 6.5, 200], [-3.3, 6.0, 200], [-2.7, 5.1, 200], [-2.1,7.0, 200], [-2.5, 3.4, 200]
, [2.3, 3.7, 200], [0.7, 3.7, 200], [6.1, 2.0, 200], [6.3, 3.1, 200], [2.0, 3.1, 200]
, [2.2, 2.3, 200], [-2.2, 3.0, 200], [2.8, 3.0, 200], [1.7, 4.5, 200], [4.5, 4.7, 200]
, [-1.0, 3.5, 200], [-2.2, 4.5, 200], [0.0, 5.1, 200], [0.9, 4.1, 200], [1.0, 5.07, 200]
, [0.0, 8.6, 200], [1, w2.0, 200], [1, 1.0,200], [0, 0, 200], [0, 0, 200]
, [0, 0, 200], [0, 0, 200], [0, 0, 200], [0, 0, 200], [0, 0, 200]
, [0, 0, 200], [0, 0, 200], [0, 0, 200], [0, 0, 200], [0, 0, 200]]
global PROWLER_PATTERN := [[-0.0, -4.88, 84], [-0.0, 14.96, 84], [-0.0, 14.96, 84], [3.8, 10.56, 84], [1.4, 7.88, 84], [0, -2, 600]]
global HEMLOK_PATTERN := [[2, 8, 40], [0, 8, 40], [0, 8, 40]]
global HEMLOK_SINGLESHOT_PATTERN := [[0, 6.3, 160]]
; supply drop weapon pattern
global SPITFIRE_PATTERN := [[3.0, 18.2, 110], [1.5, 4.8, 110], [9.6, 9.6, 110], [6.3, 7.0, 110], [3.3, 6.2, 110]
, [-0.3, 9.2, 110], [-4.5, 2.6, 110], [-9.6, -2.0, 110], [-2.7, -1.6, 110], [-3.9, 3.2, 110]
, [-2.7, 6.6, 110], [4.5, 2.0, 110], [9.9, 4.4, 110], [5.1, 1.4, 110], [9.6, -1.6, 110]
, [4.2, 1.4, 110], [1.8, 7.8, 110], [3.3, 7.6, 110], [6.9, 4.4, 110], [9.0, 1.8, 110]
, [3.9, 0.6, 113], [-1.2, 5, 113], [-6.9, 2.5, 113], [-4.5, 2, 113], [-7.8, 2.2, 113]
, [-8.1, 1, 113], [-7.8, -1, 113], [-3.3, 3.6, 113], [-4.5, 4.2, 113], [-0.3, 4.2, 113]
, [-9.6, -2.0, 113], [-2.7, -1.6, 113], [-3.9, 2.2, 113], [-2.6, 3, 113], [4.5, 1.5, 113]
, [9.9, 3.4, 113], [5.1, 1.4, 113], [9.6, -1.6, 113], [4.2, 1.4, 113], [1.8, 7.8, 113]
, [3.3, 7.6, 113], [6.9, 4.4, 113], [9.0, 1.8, 113], [3.9, 0.6, 113], [-1.2, 5.6, 113]
, [-6.9, 3.2, 113], [-4.5, 2.6, 113], [-7.8, 3.2, 113], [-8.1, 2.0, 113], [-7.8, -2.0, 113]
, [-3.3, 4.6, 113], [-4.5, 6.2, 113], [-0.3, 6.2, 113], [-9.6, -2.0, 113], [-2.7, -1.6, 113]
, [-3.9, 3.2, 113], [-2.7, 6.6, 113], [4.5, 2.0, 113], [9.9, 4.4, 113], [5.1, 1.4, 113]
, [9.6, -1.6, 113]]
global ALTERNATOR_PATTERN := [[0.0, 14.4, 109], [0.0, 13.0, 109], [0.0, 15.8, 109], [0.0, 13.9, 109], [0.0, 15.6, 109]
, [0.0, 15.6, 109], [-2.0, 12.7, 109], [-2.0, 7.3, 109], [-3.0, 13.2, 109], [-3.0, 6.6, 109]
, [-3.0, 9.8, 109], [-2.0, 1.2, 109], [-2.0, 6.8, 109], [-2.0, 4.6, 109], [-1.0, 10.0, 109]
, [0.0, 9.3, 109], [5.0, 3.2, 109], [5.0, 9.8, 109], [5.0, 0.7, 109], [5.0, 8.3, 109]
, [5.0, -0.2, 109], [5.0, 7.1, 109], [5.0, 1.7, 109], [5.0, 7.6, 109], [5.0, -0.7, 109]
, [5.0, 6.8, 109], [5.0, 0.0, 109]]

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
global single_file_mode := false

; mouse sensitivity setting
global modifier := 3.4/sens

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
    single_file_mode := IsSingleFireMode()
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
        if (CheckWeapon(R301_PIXELS))&& (CheckWeapon(R301ACOG_PIXELS)) {
            current_weapon_type := R301ACOG_WEAPON_TYPE
            current_pattern := R301ACOG_PATTERN
		} else if (CheckWeapon(R301_PIXELS)) {
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
        if (CheckWeapon(FLATLINEACOG_PIXELS))&&(CheckWeapon(FLATLINE_PIXELS)){
            current_weapon_type := FLATLINEACOG_WEAPON_TYPE
            current_pattern := FLATLINEACOG_PATTERN
        } else if (CheckWeapon(FLATLINE_PIXELS)) {
            current_weapon_type := FLATLINE_WEAPON_TYPE
            current_pattern := FLATLINE_PATTERN
        } else if (CheckWeapon(PROWLER_PIXELS)) {
            current_weapon_type := PROWLER_WEAPON_TYPE
            current_pattern := PROWLER_PATTERN
		} else if (CheckWeapon(RAMPAGE_PIXELS)) {
			current_weapon_type := RAMPAGE_WEAPON_TYPE
			current_pattern := RAMPAGE_PATTERN
        } else if (CheckWeapon(HEMLOK_PIXELS)) {
            current_weapon_type := HEMLOK_WEAPON_TYPE
            current_pattern := HEMLOK_PATTERN
            if (single_file_mode)
                current_pattern := HEMLOK_SINGLESHOT_PATTERN
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
     %hint_method%(WEAPON_NAME[current_weapon_type + 1])
    ; %hint_method%(single_file_mode)
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

    i := 1
    Loop {
        x := current_pattern[i][1]
        y := current_pattern[i][2]
        interval := current_pattern[i][3]
        if (single_file_mode || current_weapon_type == P2020_WEAPON_TYPE) {
            if (current_weapon_type == HEMLOK_WEAPON_TYPE || current_weapon_type == P2020_WEAPON_TYPE) {
                GetKeyState, LButton, LButton, P
                if LButton = U
                    Break
                DllCall("mouse_event", uint, 0x01, uint, x * modifier, uint, y * modifier)
                    Random, rand, 10, 45
                MouseClick, Left, , , 1
                sleep interval + rand
            } else {
                return
            }

        } else {
            if (!GetKeyState("LButton") || i > current_pattern.Length()) {
                DllCall("mouse_event", uint, 4, int, 0, int, 0, uint, 0, int, 0)
                break
            }
            DllCall("mouse_event", uint, 0x01, uint, x * modifier, uint, y * modifier)
                sleep interval
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
