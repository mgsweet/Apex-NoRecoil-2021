from modules.recoil_patterns import recoil_patterns
from modules.banners import banners
import numpy as np
import pytesseract
import cv2 as cv
import pyautogui
import keyboard
import win32api
import time
import sys
import os

pytesseract.pytesseract.tesseract_cmd = r"C:\\Program Files\\Tesseract-OCR\\tesseract.exe"

weapon_one_coordinates = {
    "left": 1555,
    "top": 1030,
    "width": 110,
    "height": 25
}

weapon_two_coordinates = {
    "left": 1715,
    "top": 1030,
    "width": 110,
    "height": 25
}

toggle_button = "delete"

def print_banner(ban_type, *banner):
    if ban_type == "single":
        os.system("cls")
        print(banners[banner[0]])
    elif ban_type == "double":
        os.system("cls")
        print(banners[banner[0]])
        print(banners[banner[1]])
    elif ban_type == "no-clear":
        print(banners[banner[0]])

def weapon_screenshot(select_weapon):
    if select_weapon == "one":
        image = pyautogui.screenshot(region=(weapon_one_coordinates["left"], weapon_one_coordinates["top"], weapon_one_coordinates["width"], weapon_one_coordinates["height"]))
        image = cv.cvtColor(np.array(image), cv.COLOR_RGB2BGR)
        return image
    elif select_weapon == "two":
        image = pyautogui.screenshot(region=(weapon_two_coordinates["left"], weapon_two_coordinates["top"], weapon_two_coordinates["width"], weapon_two_coordinates["height"]))
        image = cv.cvtColor(np.array(image), cv.COLOR_RGB2BGR)
        return image
    else:
        print("ERROR: Invalid weapon selection | FUNC: weapon_screenshot")
        print(f"VALUE: select_weapon = {select_weapon}")
        sys.exit(1)

def read_weapon(cv_image):
    text = pytesseract.image_to_string(cv_image)
    text = text.split()
    return str(text[0])

def left_click_state():
    left_click = win32api.GetKeyState(0x01)
    return left_click < 0

# RETURN SELECTED WEAPON | read_weapon(weapon_screenshot("one"))

active_state = False
last_toggle_state = False
active_weapon_slot = 1
active_weapon = "None"
supported_weapon = False
recognized_weapon = False

print_banner("double", "header-start", "user-options")

# LISTENER: Keyboard & Mouse Input
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
                win32api.mouse_event(0x0001, int(recoil_patterns[active_weapon][i][0]), int(recoil_patterns[active_weapon][i][1]))
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