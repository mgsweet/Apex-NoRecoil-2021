T::  ; Control+Alt+Z hotkey.
MouseGetPos, MouseX, MouseY
PixelGetColor, color, %MouseX%, %MouseY%
MsgBox The color at the current cursor position(%MouseX% %MouseY%) is %color%.
return