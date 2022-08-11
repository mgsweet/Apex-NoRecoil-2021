from modules.helpers import config_generator, read_config, get_monitor_res
from modules.recoil_patterns import recoil_patterns
from modules.native_controller import MouseMoveTo, MouseButtonState
from modules.banners import print_banner
from mss import mss
import numpy as np
import pytesseract
import cv2 as cv
import keyboard
import time
import sys

sct = mss()

pytesseract.pytesseract.tesseract_cmd = r"C:\\Program Files\\Tesseract-OCR\\tesseract.exe"

try:
    data = read_config()
except FileNotFoundError:
    try:
        config_generator()
        data = read_config()
    except KeyboardInterrupt:
        print_banner("single", "header-stop")
        print_banner("no-clear", "action-close-program")
        sys.exit(0)

toggle_button = "delete"

def dynamic_coords(top: int, left: int):
    default_res = (1920, 1080) # (width, height)
    primary_display = get_monitor_res() # (width, height)

    scaled_top = int((top / default_res[1]) * primary_display[1])
    scaled_left = int(left / default_res[0] * primary_display[0])

    return (scaled_top, scaled_left)

    if select_weapon == "one":
        image = sct.grab({
            "left": data["scan_coord_one"]["left"],
            "top": data["scan_coord_one"]["top"],
            "width": data["scan_coord_one"]["width"],
            "height": data["scan_coord_one"]["height"]
        })
        image = cv.cvtColor(np.array(image), cv.COLOR_RGB2GRAY)
        _, image = cv.threshold(image, 140, 255, cv.THRESH_BINARY)
        return image
    elif select_weapon == "two":
        image = sct.grab({
            "left": data["scan_coord_two"]["left"],
            "top": data["scan_coord_two"]["top"],
            "width": data["scan_coord_two"]["width"],
            "height": data["scan_coord_two"]["height"]
        })
        image = cv.cvtColor(np.array(image), cv.COLOR_RGB2GRAY)
        _, image = cv.threshold(image, 140, 255, cv.THRESH_BINARY)
        return image
    else:
        print("ERROR: Invalid weapon selection | FUNC: weapon_screenshot")
        print(f"VALUE: select_weapon = {select_weapon}")
        sys.exit(1)

def read_weapon(cv_image):
    excluded_char = [",", "."]

    text = pytesseract.image_to_string(cv_image)
    text = text.split()
    text = text[0]

    for char in excluded_char:
        text = text.replace(char, '')

    return str(text)

def left_click_state():
    left_click = win32api.GetKeyState(0x01)
    return left_click < 0

active_state = False
last_toggle_state = False
active_weapon_slot = 1
active_weapon = "None"
supported_weapon = False
recognized_weapon = False

print_banner("double", "header-start", "user-options")

# LISTENER: Keyboard & Mouse Input
try:
    while True:
        key_state = keyboard.is_pressed(toggle_button)
        
        print(f"RECOIL-CONTROL: {active_state} | ACTIVE-WEAPON: {active_weapon} | RECOGNIZED: {recognized_weapon} | SUPPORTED: {supported_weapon}", end=" \r")

        # TOGGLE: Enable/Disable Recoil-Control
        if key_state != last_toggle_state:
            last_toggle_state = key_state
            if last_toggle_state:
                active_state = not active_state

        # OPTION: Read Weapon-Slot & Apply Recoil-Pattern
        if keyboard.is_pressed("1"):
            active_weapon_slot = 1
            try:
                active_weapon = read_weapon(weapon_screenshot("one"))
                recognized_weapon = True
            except IndexError:
                recognized_weapon = False
                continue

        # OPTION: Read Weapon-Slot & Apply Recoil-Pattern
        if keyboard.is_pressed("2"):
            active_weapon_slot = 2
            try:
                active_weapon = read_weapon(weapon_screenshot("two"))
                recognized_weapon = True
            except IndexError:
                recognized_weapon = False
                continue

        # ACTION: Apply Recoil-Control w/ Left-Click
        if left_click_state() and active_state:
            try:
                for i in range(len(recoil_patterns[active_weapon])):
                    if left_click_state():
                        MouseMoveTo(int(recoil_patterns[active_weapon][i][0]/data["modifier_value"]), int(recoil_patterns[active_weapon][i][1]/data["modifier_value"]))
                        time.sleep(recoil_patterns[active_weapon][i][2])
                supported_weapon = True
            except KeyError:
                supported_weapon = False
                continue
        
        # OPTION: Kill Program
        if keyboard.is_pressed("/"):
            print_banner("single", "header-stop")
            print_banner("no-clear", "action-close-program")
            sys.exit(0)

        # DELAY: While-Loop | Otherwise stuttering issues in-game
        time.sleep(0.001)
except KeyboardInterrupt:
    print_banner("single", "header-stop")
    print_banner("no-clear", "action-close-program")
    sys.exit(0)
