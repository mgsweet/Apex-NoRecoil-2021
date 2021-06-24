; weapon type constant
global DEFAULT_WEAPON_TYPE := 0
global R99_WEAPON_TYPE := 1
global R301_WEAPON_TYPE := 2
global FLATLINE_WEAPON_TYPE := 3
global SPITFIRE_WEAPON_TYPE := 4
global LSTART_WEAPON_TYPE := 5
global DEVOTION_WEAPON_TYPE := 6
; current weapon type
global current_weapon_type := DEFAULT_WEAPON_TYPE
current_weapon_num := -1

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
global LSTART_PIXELS := [1663, 968, true, 1576, 1001, true, 1641, 988, false]
global DEVOTION_PIXELS := [1700, 971, true, 1662, 980, false, 1561, 972, true]

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
        if (check_weapon(LSTART_PIXELS)) {
            return LSTART_WEAPON_TYPE
        } else if (check_weapon(DEVOTION_PIXELS)) {
            return DEVOTION_WEAPON_TYPE
        }
    }
    return DEFAULT_WEAPON_TYPE
}

~1::
    sleep 50
    current_weapon_type := detect_weapon(1)
    ToolTip, %current_weapon_type%
return

~2::
    sleep 50
    current_weapon_type := detect_weapon(2)
    ToolTip, %current_weapon_type%
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
