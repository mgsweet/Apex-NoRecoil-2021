#NoEnv
#SingleInstance force
#MaxThreadsBuffer on
SendMode Input
SetWorkingDir %A_ScriptDir%
DetectHiddenWindows On
SetTitleMatchMode RegEx

RunAsAdmin()

Gosub, IniRead

; global variable
global script_version := "v1.3.10"

; Convert sens to sider format
global sider_sen := sens * 10
global UUID := "c199b79a42da4e48888b4ad66df4533c"

; GUI
SetFormat, float, 0.1
Gui, Font, S30 CDefault Bold, Verdana
Gui, Add, Text, x71 y-1 w330 h50 , Apex-NoRecoil
Gui, Font, ,
Gui, Add, Text, x123 y49 w300 h20 , UUID:%UUID%
Gui, Add, GroupBox, x11 y69 w450 h180 , Settings
Gui, Font, S13 Bold, 
Gui, Add, Text, x137 y89 w50 h30 , sens:
Gui, Add, Slider, x187 y89 w150 h30 vsider_sen gSlide range0-60 tickinterval1 AltSubmit, %sider_sen%
if (auto_fire == "1") {
    Gui, Add, CheckBox, x70 y129 w110 h30 vauto_fire Checked, auto_fire
} else {
    Gui, Add, CheckBox, x70 y129 w110 h30 vauto_fire, auto_fire
}
if (ads_only == "1") {
    Gui, Add, CheckBox, x200 y129 w110 h30 vads_only Checked, ads_only
} else {
    Gui, Add, CheckBox, x200 y129 w110 h30 vads_only, ads_only
}
if (debug == "1") {
    Gui, Add, CheckBox, x320 y129 w110 h30 vdebug Checked, debug
} else {
    Gui, Add, CheckBox, x320 y129 w110 h30 vdebug, debug
}
if (trigger_only == "1") {
    Gui, Add, CheckBox, x20 y169 w150 h30 vtrigger_only Checked, trigger_only
} else {
    Gui, Add, CheckBox, x20 y169 w150 h30 vtrigger_only, trigger_only
}
if (trigger_button == "Capslock") {
    Gui, Add, DropDownList, x170 y169 w100  vtrigger_button, Capslock||NumLock|ScrollLock|
} else if (trigger_button == "NumLock") {
    Gui, Add, DropDownList, x170 y169 w100  vtrigger_button, Capslock|NumLock||ScrollLock|
} else if (trigger_button == "ScrollLock") {
    Gui, Add, DropDownList, x170 y169 w100  vtrigger_button, Capslock|NumLock|ScrollLock||
} else {
    Gui, Add, DropDownList, x170 y169 w100  vtrigger_button, Capslock||NumLock|ScrollLock|
}
if (gold_optics == "1") {
    Gui, Add, CheckBox, x300 y169 w150 h30 vgold_optics Checked, gold_optics
} else {
    Gui, Add, CheckBox, x300 y169 w150 h30 vgold_optics, gold_optics
}
Gui, Add, Text, x20 y200 w120 h30 , resolution:
Gui, Font, S10, 
if (resolution == "3840x2160") {
    Gui, Add, DropDownList, x130 y200 vresolution, 1280x720|1366x768|1600x900|1680x1050|1728x1080|1920x1080|1920x1200|2560x1440|3840x2160||customized|
} else if (resolution == "2560x1440") {
    Gui, Add, DropDownList, x130 y200 vresolution, 1280x720|1366x768|1600x900|1680x1050|1728x1080|1920x1080|1920x1200|2560x1440||3840x2160|customized|
} else if (resolution == "1920x1200") {
    Gui, Add, DropDownList, x130 y200 vresolution, 1280x720|1366x768|1600x900|1680x1050|1728x1080|1920x1080|1920x1200||2560x1440|3840x2160|customized|
} else if (resolution == "1728x1080") {
    Gui, Add, DropDownList, x130 y200 vresolution, 1280x720|1366x768|1600x900|1680x1050|1728x1080||1920x1080|1920x1200|2560x1440|3840x2160|customized|
} else if (resolution == "1680x1050") {
    Gui, Add, DropDownList, x130 y200 vresolution, 1280x720|1366x768|1600x900|1680x1050||1728x1080|1920x1080|1920x1200|2560x1440|3840x2160|customized|
} else if (resolution == "1600x900") {
    Gui, Add, DropDownList, x130 y200 vresolution, 1280x720|1366x768|1600x900||1680x1050|1728x1080|1920x1080|1920x1200|2560x1440|3840x2160|customized|
} else if (resolution == "1366x768") {
    Gui, Add, DropDownList, x130 y200 vresolution, 1280x720|1366x768||1600x900|1600x1050|1728x1080|1920x1080|1920x1200|2560x1440|3840x2160|customized|
} else if (resolution == "1280x720") {
    Gui, Add, DropDownList, x130 y200 vresolution, 1280x720||1366x768|1600x900|1600x1050|1728x1080|1920x1080|1920x1200|2560x1440|3840x2160|customized|
} else if (resolution == "customized") {
    Gui, Add, DropDownList, x130 y200 vresolution, 1280x720|1366x768|1600x900|1600x1050|1728x1080|1920x1080|1920x1200|2560x1440|3840x2160|customized||
} else {
    Gui, Add, DropDownList, x130 y200 vresolution, 1280x720|1366x768|1600x900|1680x1050|1728x1080|1920x1080||1920x1200|2560x1440|3840x2160|customized|
}
Gui, Font, S13, 
Gui, Add, Text, x20 y225 w120 h20 , colorblind:
Gui, Font, S10, 
if (colorblind == "Protanopia") {
    Gui, Add, DropDownList, x130 y225 vcolorblind, Normal|Protanopia||Deuteranopia|Tritanopia|
} else if (colorblind == "Deuteranopia") {
    Gui, Add, DropDownList, x130 y225 vcolorblind, Normal|Protanopia|Deuteranopia||Tritanopia|
} else if (colorblind == "Tritanopia") {
    Gui, Add, DropDownList, x130 y225 vcolorblind, Normal|Protanopia|Deuteranopia|Tritanopia||
} else {
    Gui, Add, DropDownList, x130 y225 vcolorblind, Normal||Protanopia|Deuteranopia|Tritanopia|
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

        IniWrite, "1920x1080", settings.ini, screen settings, resolution
        IniWrite, "Normal"`n, settings.ini, screen settings, colorblind
        IniWrite, "5.0", settings.ini, mouse settings, sens
        IniWrite, "1.0", settings.ini, mouse settings, zoom_sens
        IniWrite, "1", settings.ini, mouse settings, auto_fire
        IniWrite, "1"`n, settings.ini, mouse settings, ads_only
        IniWrite, "0"`n, settings.ini, trigger settings, trigger_only
        IniWrite, "Capslock"`n, settings.ini, trigger settings, trigger_button
        IniWrite, "80", settings.ini, voice settings, volume
        IniWrite, "7"`n, settings.ini, voice settings, rate
        IniWrite, "0", settings.ini, other settings, debug
        IniWrite, "0", settings.ini, other settings, gold_optics
        if (A_ScriptName == "gui.ahk") {
            Run "gui.ahk"
        } else if (A_ScriptName == "gui.exe") {
            Run "gui.exe"
        }
    }
    Else {
        IniRead, resolution, settings.ini, screen settings, resolution
        IniRead, colorblind, settings.ini, screen settings, colorblind
        IniRead, sens, settings.ini, mouse settings, sens
        IniRead, auto_fire, settings.ini, mouse settings, auto_fire
        IniRead, ads_only, settings.ini, mouse settings, ads_only
        IniRead, trigger_only, settings.ini, trigger settings, trigger_only
        IniRead, trigger_button, settings.ini, trigger settings, trigger_button
        IniRead, volume, settings.ini, voice settings, volume
        IniRead, rate, settings.ini, voice settings, rate
        IniRead, debug, settings.ini, other settings, debug
        IniRead, gold_optics, settings.ini, other settings, gold_optics
    }
return

btSave:
    Gui, submit
    IniWrite, "%resolution%", settings.ini, screen settings, resolution
    IniWrite, "%colorblind%", settings.ini, screen settings, colorblind
    IniWrite, "%sens%", settings.ini, mouse settings, sens
    IniWrite, "%auto_fire%", settings.ini, mouse settings, auto_fire
    IniWrite, "%ads_only%", settings.ini, mouse settings, ads_only
    IniWrite, "%trigger_only%", settings.ini, trigger settings, trigger_only
    IniWrite, "%trigger_button%", settings.ini, trigger settings, trigger_button
    IniWrite, "%debug%", settings.ini, other settings, debug    
    IniWrite, "%gold_optics%", settings.ini, other settings, gold_optics
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

RunAsAdmin()
{
	Global 0
	IfEqual, A_IsAdmin, 1, Return 0
	
	Loop, %0%
		params .= A_Space . %A_Index%
	
	DllCall("shell32\ShellExecute" (A_IsUnicode ? "":"A"),uint,0,str,"RunAs",str,(A_IsCompiled ? A_ScriptFullPath : A_AhkPath),str,(A_IsCompiled ? "": """" . A_ScriptFullPath . """" . A_Space) params,str,A_WorkingDir,int,1)
	ExitApp
}

GuiClose:
ExitApp
