#NoEnv
#SingleInstance force
#MaxThreadsBuffer on
SendMode Input
SetWorkingDir %A_ScriptDir%
DetectHiddenWindows On
SetTitleMatchMode RegEx
; if not A_IsAdmin
; {
; 	Run *RunAs "%A_ScriptFullPath%"  
; 	ExitApp
; }
Gosub, IniRead
; Convert sens to sider format
siderSen := sens * 10
; GUI
SetFormat, float, 0.1
Gui, Font, S30 CDefault Bold, Verdana
Gui, Add, Text, x71 y-1 w330 h50 , Apex-NoRecoil
Gui, Font, ,
Gui, Add, Text, x216 y49 w40 h20 , v1.2.2 
Gui, Add, GroupBox, x11 y69 w450 h180 , Settings
Gui, Font, S13 Bold, 
Gui, Add, Text, x162 y89 w50 h30 , sens:
Gui, Add, Slider, x212 y89 w100 h30 vSiderSen gSlide range0-50 tickinterval1 AltSubmit, %siderSen%
if (auto_fire == "on") {
    Gui, Add, CheckBox, x182 y129 w110 h30 vAutofire Checked, auto_fire
} else {
    Gui, Add, CheckBox, x182 y129 w110 h30 vAutofire, auto_fire
}
if (ads_only == "on") {
    Gui, Add, CheckBox, x182 y169 w110 h30 vAdsOnly Checked, ads_only
} else {
    Gui, Add, CheckBox, x182 y169 w110 h30 vAdsOnly, ads_only
}
Gui, Add, Text, x112 y209 w120 h30 , resolution:
Gui, Font, S10, 
if (resolution == "3840x2160") {
    Gui, Add, DropDownList, x232 y209 vResolution, 1080x1920|3840x2160||
} else {
    Gui, Add, DropDownList, x232 y209 vResolution, 1080x1920||3840x2160
} 
Gui, Font, S18 Bold, 
Gui, Add, Button, x142 y259 w190 h40 , Save and Run!
Gui, Font, , 
Gui, Add, Link, x122 y309 w230 h20 , <a href="https://github.com/mgsweet/Apex-NoRecoil-2021">github.com/mgsweet/Apex-NoRecoil-2021</a>
Gui, Show, x643 y259 h342 w477, New GUI Window
Return

Slide:
    Gui,Submit,NoHide
    siderSenTips := Floor(siderSen)/10
    tooltip % siderSenTips
    SetTimer, RemoveToolTip, 500
return

RemoveToolTip:
    SetTimer, RemoveToolTip, Off
    ToolTip
return

GuiClose:
ExitApp

IniRead:
    IfNotExist, settings.ini
    {
        MsgBox, Couldn't find settings.ini. I'll create one for you.
        IniWrite, "1080x1920"`n, settings.ini, screen settings, resolution
        IniWrite, "5.0", settings.ini, mouse settings, sens
        IniWrite, "1.0", settings.ini, mouse settings, zoom_sens
        IniWrite, "on", settings.ini, mouse settings, auto_fire
        IniWrite, "off"`n, settings.ini, mouse settings, ads_only
        IniWrite, "80", settings.ini, voice settings, volume
        IniWrite, "7"`n, settings.ini, voice settings, rate
        IniWrite, "narrator", settings.ini, script configs, script_version
        IniWrite, "apexmaster.ahk"`n, settings.ini, script configs, script_name
        ; IniWrite, "apexmaster.exe"`n, settings.ini, script configs, script_name
        IniRead, script_name, settings.ini, script configs, script_name
        Run, %script_name%
    }
    Else {
        IniRead, resolution, settings.ini, screen settings, resolution
        IniRead, sens, settings.ini, mouse settings, sens
        IniRead, zoom_sens, settings.ini, mouse settings, zoom_sens
        IniRead, auto_fire, settings.ini, mouse settings, auto_fire
        IniRead, ads_only, settings.ini, mouse settings, ads_only
        IniRead, volume, settings.ini, voice settings, volume
        IniRead, rate, settings.ini, voice settings, rate
        IniRead, script_version, settings.ini, script configs, script_version
    }
return