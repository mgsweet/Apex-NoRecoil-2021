import ctypes

# C-Struct Definitions
PUL = ctypes.POINTER(ctypes.c_ulong)


class KeyBdInput(ctypes.Structure):
    _fields_ = [
        ("wVk", ctypes.c_ushort),
        ("wScan", ctypes.c_ushort),
        ("dwFlags", ctypes.c_ulong),
        ("time", ctypes.c_ulong),
        ("dwExtraInfo", PUL),
    ]


class HardwareInput(ctypes.Structure):
    _fields_ = [
        ("uMsg", ctypes.c_ulong),
        ("wParamL", ctypes.c_short),
        ("wParamH", ctypes.c_ushort),
    ]


class MouseInput(ctypes.Structure):
    _fields_ = [
        ("dx", ctypes.c_long),
        ("dy", ctypes.c_long),
        ("mouseData", ctypes.c_ulong),
        ("dwFlags", ctypes.c_ulong),
        ("time", ctypes.c_ulong),
        ("dwExtraInfo", PUL),
    ]


class Input_I(ctypes.Union):
    _fields_ = [("ki", KeyBdInput), ("mi", MouseInput), ("hi", HardwareInput)]


class Input(ctypes.Structure):
    _fields_ = [("type", ctypes.c_ulong), ("ii", Input_I)]


class MouseEvent:
    # Mouse Move
    MOUSEEVENTF_MOVE = 0x0001

    # Left-Button Down
    MOUSEEVENTF_LEFTDOWN = 0x0002
    # Left-Button Up
    MOUSEEVENTF_LEFTUP = 0x0004

    # Right-Button Down
    MOUSEEVENTF_RIGHTDOWN = 0x0008
    # Right-Button Up
    MOUSEEVENTF_RIGHTUP = 0x0010

    # Middle-Button Down
    MOUSEEVENTF_MIDDLEDOWN = 0x0020
    # Middle-Button Up
    MOUSEEVENTF_MIDDLEUP = 0x0040

    # Mouse-Wheel Roll
    MOUSEEVENTF_WHEEL = 0x0800

    # Absolute Move
    MOUSEEVENTF_ABSOLUTE = 0x8000

    # Primary Display Width
    SM_CXSCREEN = 0
    # Primary Display Height
    SM_CYSCREEN = 1

    # Execute Mouse-Event
    def _do_event(self, flags, x_pos, y_pos, data, extra_info):
        return ctypes.windll.user32.mouse_event(flags, x_pos, y_pos, data, extra_info)

    # Convert Mouse-Value to Human Readable text value
    def _get_button_value(self, button_name, button_up=False):
        buttons = 0

        if button_name.find("right") >= 0:
            buttons = self.MOUSEEVENTF_RIGHTDOWN

        if button_name.find("left") >= 0:
            buttons = buttons + self.MOUSEEVENTF_LEFTDOWN

        if button_name.find("middle") >= 0:
            buttons = buttons + self.MOUSEEVENTF_MIDDLEDOWN

        if button_up:
            buttons = buttons << 1

        return buttons


# Click Mouse-Event
def MouseClick(button_name="left"):
    MouseEvent._do_event(
        MouseEvent,
        MouseEvent._get_button_value(
            MouseEvent, button_name=button_name, button_up=False
        ),
        0,
        0,
        0,
        0,
    )
    MouseEvent._do_event(
        MouseEvent,
        MouseEvent._get_button_value(
            MouseEvent, button_name=button_name, button_up=True
        ),
        0,
        0,
        0,
        0,
    )


# Move Mouse-Event
def MouseMoveTo(x, y):
    extra = ctypes.c_ulong(0)
    ii_ = Input_I()
    ii_.mi = MouseInput(x, y, 0, 0x0001, 0, ctypes.pointer(extra))

    command = Input(ctypes.c_ulong(0), ii_)
    ctypes.windll.user32.SendInput(1, ctypes.pointer(command), ctypes.sizeof(command))
