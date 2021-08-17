import numpy as np
import pytesseract
import cv2 as cv
import pyautogui
import keyboard
import win32api
import time
import sys

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

banners = {
    "header-start": """
 █████╗ ██████╗ ███████╗██╗  ██╗     ███╗   ██╗ ██████╗ ██████╗ ███████╗ ██████╗ ██████╗ ██╗██╗     
██╔══██╗██╔══██╗██╔════╝╚██╗██╔╝     ████╗  ██║██╔═══██╗██╔══██╗██╔════╝██╔════╝██╔═══██╗██║██║     
███████║██████╔╝█████╗   ╚███╔╝█████╗██╔██╗ ██║██║   ██║██████╔╝█████╗  ██║     ██║   ██║██║██║     
██╔══██║██╔═══╝ ██╔══╝   ██╔██╗╚════╝██║╚██╗██║██║   ██║██╔══██╗██╔══╝  ██║     ██║   ██║██║██║     
██║  ██║██║     ███████╗██╔╝ ██╗     ██║ ╚████║╚██████╔╝██║  ██║███████╗╚██████╗╚██████╔╝██║███████╗
╚═╝  ╚═╝╚═╝     ╚══════╝╚═╝  ╚═╝     ╚═╝  ╚═══╝ ╚═════╝ ╚═╝  ╚═╝╚══════╝ ╚═════╝ ╚═════╝ ╚═╝╚══════╝
by: krampus-nuggets | credit: mgsweet
    """,
    "header-stop": """
██████╗ ██╗   ██╗███████╗       ██╗ 
██╔══██╗╚██╗ ██╔╝██╔════╝    ██╗╚██╗
██████╔╝ ╚████╔╝ █████╗      ╚═╝ ██║
██╔══██╗  ╚██╔╝  ██╔══╝      ██╗ ██║
██████╔╝   ██║   ███████╗    ╚═╝██╔╝
╚═════╝    ╚═╝   ╚══════╝       ╚═╝
    """,
    "user-options": """
All available options listed below:

1. Toggle recoil control | Press DEL
2. Load primary pattern | Press 1
3. Load secondary pattern | Press 2
4. Kill program | Press /
    """,
    "action-close-program": "ACTION: Program Closed"
}

toggle_button = "delete"

def print_banner():
    pass

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
modifier = 2.5
active_weapon_slot = 1
active_weapon = ""

while True:
    key_state = keyboard.is_pressed(toggle_button)
    
    if key_state != last_toggle_state:
        last_toggle_state = key_state
        if last_toggle_state:
            active_state = not active_state
            if active_state:
                print("RECOIL-CONTROL: ENABLED")
            else:
                print("RECOIL-CONTROL: DISABLED")

    if keyboard.is_pressed("1"):
        active_weapon_slot = 1
        active_weapon = read_weapon(weapon_screenshot("one"))
        print(f"Weapon Slot: {active_weapon_slot}\nWeapon Name: {active_weapon}")

    if keyboard.is_pressed("2"):
        active_weapon_slot = 2
        active_weapon = read_weapon(weapon_screenshot("two"))
        print(f"Weapon Slot: {active_weapon_slot}\nWeapon Name: {active_weapon}")

    if left_click_state() and active_state:
        for i in range(len(recoil_patterns[active_weapon])):
            win32api.mouse_event(0x0001, int(recoil_patterns[active_weapon][i][0]), int(recoil_patterns[active_weapon][i][1]))
            time.sleep(recoil_patterns[active_weapon][i][2])

    # While loop delay
    time.sleep(0.001)