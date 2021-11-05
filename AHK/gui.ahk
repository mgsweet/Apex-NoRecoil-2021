SetFormat, float, 0.1
Gui, Font, S30 CDefault Bold, Verdana
Gui, Add, Text, x71 y-1 w330 h50 , Apex-NoRecoil
Gui, Font, ,
Gui, Add, Text, x216 y49 w40 h20 , v1.2.2 
Gui, Add, GroupBox, x11 y69 w450 h180 , Settings
Gui, Font, S13 Bold, 
Gui, Add, Text, x162 y89 w50 h30 , sens:
Gui, Add, Slider, x212 y89 w100 h30 vSlider gSlide range0-50 tickinterval1 AltSubmit, 0
Gui, Add, CheckBox, x182 y129 w110 h30 , auto_fire
Gui, Add, CheckBox, x182 y169 w110 h30 , ads_only
Gui, Add, Text, x112 y209 w120 h30 , resolution:
Gui, Font, S10, 
Gui, Add, DropDownList, x232 y209 vResolution, 1080x1920|3840x2160
Gui, Font, S18 Bold, 
Gui, Add, Button, x142 y259 w190 h40 , Save and Run!
Gui, Font, , 
Gui, Add, Text, x122 y309 w230 h20 , github.com/mgsweet/Apex-NoRecoil-2021
Gui, Show, x643 y259 h342 w477, New GUI Window
Return

Slide:
    Gui,Submit,NoHide
    val := Floor(slider)/10
    ; fra := Mod(int, 10)
    ; fra := SubStr(fra, InStr(fra,".")+1, 1 )
    ; val := Floor(int) "." fra
    tooltip % val
    SetTimer, RemoveToolTip, 500
return

RemoveToolTip:
    SetTimer, RemoveToolTip, Off
    ToolTip
return

GuiClose:
ExitApp