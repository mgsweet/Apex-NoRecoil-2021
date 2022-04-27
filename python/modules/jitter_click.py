import time
import random
import keyboard
import win32api, win32con

def left_click():
    win32api.mouse_event(win32con.MOUSEEVENTF_LEFTDOWN,0,0)
    time.sleep(0.01)
    win32api.mouse_event(win32con.MOUSEEVENTF_LEFTUP,0,0)

def left_click_state():
    left_click = win32api.GetKeyState(0x01)
    return left_click < 0

toggle_button = "delete"
active_state = False
last_toggle_state = False

recoil_patterns = {
    "R-301": [[0, 0, 0.0], [-5, 8, 0.0], [-7, 6, 0.0], [-1, 8, 0.0], [-5, 9, 0.0], [-2, 9, 0.0],
    [0, 6, 0.0], [0, 5, 0.0], [6, 2, 0.0], [-7, 3, 0.0], [1, 2, 0.0], [2, 5, 0.0], [0, 6, 0.0],
    [-2, 5, 0.0], [1, 4, 0.0], [-2, 4, 0.0], [-3, 1, 0.0], [-4, 4, 0.0], [-6, -2, 0.0], [-1, -4, 0.0],
    [3, 0, 0.0], [2, 1, 0.0], [-2, 0, 0.0], [-2, -3, 0.0]]
}

while True:
    key_state = keyboard.is_pressed(toggle_button)
    click_delay = round(random.uniform(0.072, 0.081), 3)

    print(f"TOOL-ENABLED: {active_state} | CLICK-DELAY: {click_delay}", end=" \r")

    # TOGGLE: Enable/Disable Recoil-Control
    if key_state != last_toggle_state:
        last_toggle_state = key_state
        if last_toggle_state:
            active_state = not active_state

    # ACTION: Apply Recoil-Control w/ Left-Click
    if left_click_state() and active_state:
        for i in range(len(recoil_patterns["R-301"])):
            left_click()
            win32api.mouse_event(0x0001, int(recoil_patterns["R-301"][i][0]), int(recoil_patterns["R-301"][i][1]/1.5))
            time.sleep(click_delay)

    time.sleep(0.001)
