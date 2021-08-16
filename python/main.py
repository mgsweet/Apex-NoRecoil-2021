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

recoil_patterns = {
    "R-301" : [[-3.5, 10.4, 0.080], [4.4, 10.6, 0.080], [-6.4, 9.5, 0.080], [-1.2, 10.0, 0.080], [-5.3, 7.6, 0.080]
, [-0.4, 4.1, 0.080], [-1.8, 3.3, 0.080], [-4.1, 1.9, 0.080], [-2.4, 3.3, 0.080], [-3.2, 1.0, 0.080]
, [0.0, 3.3, 0.080], [2.0, 2.2, 0.080], [5.0, 2.8, 0.080], [4.7, 2.3, 0.080], [5.0, 1.9, 0.080]
, [5.2, 0.9, 0.080], [3.2, 0.9, 0.080], [0.0, 2.2, 0.080], [-1.1, 4.2, 0.080], [-3.1, 2.8, 0.080]
, [-3.6, 1.3, 0.080], [-3.6, 0.0, 0.080], [-2.6, 1.4, 0.080], [-2.4, 1.4, 0.080], [-3.0, 0.0, 0.080]
, [0.0, 0.0, 0.080], [0.0, 0.0, 0.080], [0.0, 0.0, 0.080], [0.0, 0.0, 0.080], [0.0, 0.0, 0.080]],
    "R-99": [[-1.6, 7, 0.053], [0.1, 7.5, 0.053], [2.3, 4.9, 0.053], [-1.8, 10, 0.053], [-3.3, 15.4, 0.053]
, [-6.3, 12, 0.053], [-5.5, 9.7, 0.053], [-2.5, 10.8, 0.053], [0.2, 11, 0.052], [2.3, 6.8, 0.052]
, [4.5, 5.3, 0.052], [0.9, 5.1, 0.052], [1.6, 9.5, 0.052], [-1.1, 4, 0.052], [-4.9, 1, 0.052]
, [-2.3, 1.8, 0.052], [-4.5, 0.5, 0.052], [4, 1.3, 0.052], [0, 0, 0.052], [2.5, 0.7, 0.052]
, [3.5, 0.7, 0.052], [4, 4, 0.052], [3.5, 0, 0.052], [4.6, 0, 0.052], [2, 0, 0.052]
, [2, 0, 0.052], [-5, -4, 0.052], [-5, 4, 0.052], [-5, -4, 0.052], [0, 4, 0.052]]
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
    """
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