#NoEnv
#SingleInstance force
#MaxThreadsBuffer on
SendMode Input
SetWorkingDir %A_ScriptDir%
DetectHiddenWindows On
SetTitleMatchMode RegEx
if not A_IsAdmin
{
    Run *RunAs "%A_ScriptFullPath%" 
    ExitApp
}
Gosub, IniRead

; global variable
script_version := "v1.2.2"

; Convert sens to sider format
sider_sen := sens * 10

; GUI
SetFormat, float, 0.1
Gui, Font, S30 CDefault Bold, Verdana
Gui, Add, Text, x71 y-1 w330 h50 , Apex-NoRecoil
Gui, Font, ,
Gui, Add, Text, x216 y49 w40 h20 , %script_version%
Gui, Add, GroupBox, x11 y69 w450 h180 , Settings
Gui, Font, S13 Bold, 
Gui, Add, Text, x162 y89 w50 h30 , sens:
Gui, Add, Slider, x212 y89 w100 h30 vsider_sen gSlide range0-50 tickinterval1 AltSubmit, %sider_sen%
if (auto_fire == "1") {
    Gui, Add, CheckBox, x182 y129 w110 h30 vauto_fire Checked, auto_fire
} else {
    Gui, Add, CheckBox, x182 y129 w110 h30 vauto_fire, auto_fire
}
if (ads_only == "1") {
    Gui, Add, CheckBox, x182 y169 w110 h30 vads_only Checked, ads_only
} else {
    Gui, Add, CheckBox, x182 y169 w110 h30 vads_only, ads_only
}
Gui, Add, Text, x112 y209 w120 h30 , resolution:
Gui, Font, S10, 
if (resolution == "3840x2160") {
    Gui, Add, DropDownList, x232 y209 vresolution, 1080x1920|2560x1440|3840x2160||
} else if (resolution == "2560x1440") {
    Gui, Add, DropDownList, x232 y209 vresolution, 1080x1920|2560x1440||3840x2160|
} else {
    Gui, Add, DropDownList, x232 y209 vresolution, 1080x1920||3840x2160|2560x1440
} 
Gui, Font, S18 Bold, 
Gui, Add, Button, x142 y259 w190 h40 gbtSave, Save and Run!
Gui, Font, , 
Gui, Add, Link, x158 y307 w160 h18 , <a href="https://github.com/mgsweet/Apex-NoRecoil-2021">mgsweet/Apex-NoRecoil-2021</a>
ActiveMonitorInfo(X, Y, Width, Height)
xPos := Width / 2 - 477 / 2
yPos := Height / 2 - 335 / 2
Gui, Show, x%xPos% y%yPos% h335 w477, Apex NoRecoil %script_version%
Return

Slide:
    Gui,Submit,NoHide
    sens := sider_sen/10
    tooltip % sens
    SetTimer, RemoveToolTip, 500
return

RemoveToolTip:
    SetTimer, RemoveToolTip, Off
    ToolTip
return

IniRead:
    IfNotExist, settings.ini
    {
        MsgBox, Couldn't find settings.ini. I'll create one for you.

        IniWrite, "1080x1920"`n, settings.ini, screen settings, resolution
        IniWrite, "5.0", settings.ini, mouse settings, sens
        IniWrite, "1.0", settings.ini, mouse settings, zoom_sens
        IniWrite, "1", settings.ini, mouse settings, auto_fire
        IniWrite, "0"`n, settings.ini, mouse settings, ads_only
        IniWrite, "80", settings.ini, voice settings, volume
        IniWrite, "7", settings.ini, voice settings, rate
        Run gui.ahk
    }
    Else {
        IniRead, resolution, settings.ini, screen settings, resolution
        IniRead, sens, settings.ini, mouse settings, sens
        IniRead, auto_fire, settings.ini, mouse settings, auto_fire
        IniRead, ads_only, settings.ini, mouse settings, ads_only
        IniRead, volume, settings.ini, voice settings, volume
        IniRead, rate, settings.ini, voice settings, rate
    }
return

btSave:
    Gui, submit
    IniWrite, "%resolution%", settings.ini, screen settings, resolution
    IniWrite, "%sens%", settings.ini, mouse settings, sens
    IniWrite, "%auto_fire%", settings.ini, mouse settings, auto_fire
    IniWrite, "%ads_only%", settings.ini, mouse settings, ads_only
    if (A_ScriptName == "gui.ahk") {
        CloseScript("apexmaster.ahk")
        Run "apexmaster.ahk"
    } else if (A_ScriptName == "gui.exe") {
        CloseScript("apexmaster.exe")
        Run "apexmaster.exe"
    }
ExitApp

CloseScript(Name) {
	DetectHiddenWindows On
	SetTitleMatchMode RegEx
	IfWinExist, i)%Name%.* ahk_class AutoHotkey
		{
		WinClose
		WinWaitClose, i)%Name%.* ahk_class AutoHotkey, , 2
		If ErrorLevel
			return "Unable to close " . Name
		else
			return "Closed " . Name
		}
	else
		return Name . " not found"
	}

ActiveMonitorInfo(ByRef X, ByRef Y, ByRef Width, ByRef Height)
{
    CoordMode, Mouse, Screen
    MouseGetPos, mouseX, mouseY
    SysGet, monCount, MonitorCount
    Loop %monCount% {
        SysGet, curMon, Monitor, %a_index%
        if ( mouseX >= curMonLeft and mouseX <= curMonRight and mouseY >= curMonTop and mouseY <= curMonBottom ) {
            X := curMonTop
            y := curMonLeft
            Height := curMonBottom - curMonTop
            Width := curMonRight - curMonLeft
            return
        }
    }
}

GuiClose:
ExitApp