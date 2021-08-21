import pyautogui
import keyboard
import win32api
import win32con
import time
import sys
import os

file_name = input("Please input weapon name below [Example - r-99]:\n").upper()
fire_rate_delay = float(input("Please input weapon fire-rate delay below [Example - 0.055]:\n"))
recoil_file = open(f"{file_name}.txt", "w")

banners = {
    "header-main" : """
╔═╗╔═╗╔╦╗╔╦╗╔═╗╦═╗╔╗╔
╠═╝╠═╣ ║  ║ ║╣ ╠╦╝║║║
╩  ╩ ╩ ╩  ╩ ╚═╝╩╚═╝╚╝
╔╦╗╦═╗╔═╗╔═╗╦╔═╔═╗╦═╗
 ║ ╠╦╝╠═╣║  ╠╩╗║╣ ╠╦╝
 ╩ ╩╚═╩ ╩╚═╝╩ ╩╚═╝╩╚═
by: krampus-nuggets | credit: CharlesDankoff
    """,
    "user-options" : """
1. Enable/Disable Pattern-Tracker | Press 1
2. Generate a TXT file with Recoil-Patterns | Press 2
3. Kill Program | Press CTRL + C
    """
}

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

def left_click_state():
    left_click = win32api.GetAsyncKeyState(win32con.VK_LBUTTON)
    return left_click < 0

def convert_value(positional_value):
    if positional_value == 0:
        # Return Zero
        return positional_value
    else:
        # Convert to Positve | Convert to Negative
        return -positional_value

def build_recoil_list(x_value, y_value, fire_rate):
    x = convert_value(x_value)
    y = convert_value(y_value)
    return [x, y, fire_rate]

recoil_patterns = []
template = '"{}": {}'
active_state = False
last_toggle_state = False
previous_x = 0
previous_y = 0

print_banner("double", "header-main", "user-options")

try:
    while True:
        key_state = keyboard.is_pressed("1")
        x, y = pyautogui.position()
        coordinates = f"X: {str(x).ljust(4)} | Y: {str(y).ljust(4)}"
        print(f"{coordinates} | PATTERN-TRACKER: {active_state} | Saved Patterns: {len(recoil_patterns)}", end=" \r")

        if key_state != last_toggle_state:
            last_toggle_state = key_state
            if last_toggle_state:
                active_state = not active_state

        if left_click_state() and active_state:
            if previous_x == 0 and previous_y == 0:
                previous_x = x
                previous_y = y
                moved_x = 0
                moved_y = 0
            else:
                moved_x = int((x - previous_x + 1)/2)  # div by 2 round up => real pattern
                moved_y = int((y - previous_y + 1)/2)  # because you should click x2 zoomed pattern
                previous_x = x
                previous_y = y

            recoil_patterns.append(build_recoil_list(moved_x, moved_y, fire_rate_delay))
            time.sleep(0.15)

        if keyboard.is_pressed("2"):
            recoil_file.write(template.format(file_name, recoil_patterns))
            recoil_file.close
            print("ACTION: Recoil-Pattern file saved | Closing Program")
            sys.exit(0)
        
        time.sleep(0.001)
except KeyboardInterrupt:
    print("ACTION: Closed Program")
    sys.exit(0)
