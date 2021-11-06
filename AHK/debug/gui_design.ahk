SetFormat, float, 0.1
Gui, Font, S30 CDefault Bold, Verdana
Gui, Add, Text, x71 y-1 w330 h50 , Apex-NoRecoil
Gui, Font, ,
Gui, Add, Text, x216 y49 w40 h20 , v1.2.2 
Gui, Add, GroupBox, x11 y69 w450 h180 , Settings
Gui, Font, S13 Bold, 
Gui, Add, Text, x162 y89 w50 h30 , sens:
Gui, Add, Slider, x212 y89 w100 h30 vSiderSen gSlide range0-50 tickinterval1 AltSubmit, 50
Gui, Add, CheckBox, x182 y129 w110 h30 vAutofire, auto_fire
Gui, Add, CheckBox, x182 y169 w110 h30 vAdsOnly Checked, ads_only
Gui, Add, Text, x112 y209 w120 h30 , resolution:
Gui, Font, S10, 
Gui, Add, DropDownList, x232 y209 vResolution, 1080x1920|3840x2160||
Gui, Font, S18 Bold, 
Gui, Add, Button, x142 y259 w190 h40 , Save and Run!
Gui, Font, , 
Gui, Add, Text, x158 y307 w160 h18 , <a href="https://github.com/mgsweet/Apex-NoRecoil-2021">mgsweet/Apex-NoRecoil-2021</a>
Gui, Show, x643 y259 h342 w477, New GUI Window
Return