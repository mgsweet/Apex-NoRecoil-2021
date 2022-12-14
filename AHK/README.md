# Apex-NoRecoil-2021 - AHK
An AutoHotKey script to minimize recoil with auto weapon detection for Apex Legends. (works on multiple resolutions). 

Apex Legends 压枪宏，带武器自动检测，支持多种分辨率无边框全屏模式。

## Description
This repository contains an Autohotkey script to help you minimize weapon recoil. Your weapon is auto-detected by the script (no need to press the F key anymore! XD). The detection is based on a straightforward and naive strategy (I call it three-pixel-detection). It is pretty safe because all it does is just capture some pixels and then use mouse DllCall to move your mouse. Run the compiled version if you want more protection.

该库包含了一个带自动武器检测的 Apex Legends 压枪宏，不读内存，不注入游戏文件，纯粹就是识别像素颜色并帮助你移动鼠标，这就类似于那些淘宝卖好几百的主播专用压枪宏。

![apex](https://user-images.githubusercontent.com/15327389/140604672-a4649ba6-9e81-49b2-981a-e79bfa4278fc.png)


## Usage
How to run:
- Download and install [AutoHotKey](https://www.autohotkey.com/)
- Download Python3
- Download this repo.
- run the `uuid_generator.py` in `AHK/src`
- run the `AHK/src/gui.ahk`, do some configuration works.
- Then click `Save and Run`. The GUI will then disappear and `apexmaster.ahk` will run in the background.
- Run the game in borderless mode.
- After running the script, every time you press `1`, `2`, `B`, `R` or `E`, the script will detect your current weapon and provide compensation while you click `L Button` while holding your `R Button` (is you click ads_only). It cannot detect the weapon when you get one by "licking a dead player's box"(I haven't done this yet). But once you click any of the four buttons mention above, the detection should work :)
- Enjoy!

How to close:
- right click the tiny icon and quit.
- or press `End` key

Config description:
- auto_fire: To run in a more safer mode, untick `auto_fire`. This would remove the auto fire feature for single shot weapon like G7, P2020, etc.
- ads_only: To make the script work only in ads mode, tick `ads_only`
- sens: The default mouse sensitivity is `5.0`. Change the sens to yours.

如何運行：
- 下載並運行 `apexmaster-v1.x.x.exe`。
- 點擊 `Save and Run`， 然後圖形界面會消失且 `apexmaster.exe`會在後臺運行。
- 在無邊框模式下啓動游戲
- 武器检测会在你按 `1`, `2`, `B`, `R` 或 `E` 时进行，舔包时通过鼠标点击获得的武器在一开始不会被检测，但在你按下上面所述四个按钮中任意一个后武器压枪补偿就会更新。

怎麽關閉：
- 鼠標右擊小圖標並退出即可
- 或使用键盘 `End` 键退出

設置項説明：
- auto_fire：如果你不想要单发武器全自动的功能， 勾選此項（会更安全）。
- ads_only: 如果你只想在 ADS 模式下触发压枪的功能，勾選此項。
- sens: 對應游戲裏設置的鼠標靈敏度

## Update
### 2022/12/14 version 1.3.8 (still, from [Eternal-Walnut](https://github.com/Eternal-Walnut))
- Add single mode checker
- Update Alternator pattern

### 2022/12/04 version 1.3.7 (thanks to [Eternal-Walnut](https://github.com/Eternal-Walnut))
- update RE45's pattern
- update Alternator's pattern
- add colorblind option
- fix re45 color problem

### 2022/09/25 version 1.3.6
- update Havoc's pattern
- update Devotion's pattern
- add green.ahk which comes without the gold optics feature
- fix auto-fire feature's bugs

### 2022/09/16 version 1.3.5
- update Havoc's pattern
- fix gold optics bugs

### 2022/09/12 version 1.3.4
- support Sella
- update Spitfire's pattern
- add my recoil generator to /debug
- fix gold optics bugs

### 2022/09/07 version 1.3.3
- remove peacekeeper fast reload since the bug has been fixed
- improve gold optics aimbot 

### 2022/08/25 version 1.3.2
- fix lbutton click bug

### 2022/08/24 version 1.3.1
- added gold optics aimbot to more guns
- fixed known bugs created by the gold optics features
- added a trigger for the gold optics feature

### 2022/08/21 version 1.3.0
- update some patterns
- debug mode is provided for gui customization
- peacekeeper fast reload is now supported (only for 2560x1440) 
- add wingman gold optics aimbot (may cause u banned, still in testing)

### 2022/08/10 version 1.2.10
- update to support weapon type changes of S14 (from [jayking999](https://github.com/jayking999))
- now gui.ahk also has a UUID
- provide a better way to support customized resolutions.

### 2022/05/13 version 1.2.9
- remove `bin/`, which may cause people to get banned
- move spitfire out of supply weapon (from [VerTox](https://github.com/VerTox))

### 2021/02/11 version 1.2.8
- change alternator back to light weapon
- change volt to supply weapon

### 2021/02/9 version 1.2.7
- support 1728x1080 and 1920x1200 (from [SiLeNT-Sooul](https://github.com/SiLeNT-Sooul))
- remove wingman auto-fire
- remove exe, which will be moved to releases

### 2021/12/25 version 1.2.6
- built-in ahkhider
- support 1280*720
- support 1366*768
- add a UUID generator to help do a slight change

### 2021/12/04 version 1.2.5
- support 1680x1050 
- remove gold optics shotgun aimbot (because people mentioned  they are banned because of it)

### 2021/11/21 version 1.2.4
- support 3030
- update patterns
- new feature: gold optics shotgun aimbot

### 2021/11/9 version 1.2.3
- support 1600x900
- update patterns
- fix spelling mistakes
- now `End` can exit the script

### 2021/11/6 version 1.2.2
- support multiple resolution (1080, 2k, 4k)
- add GUI for config setting

### 2021/11/5 version 1.2.1
- support car smg
- fix g7 color problem

### 2021/10/16 version 1.1.1
- Fix a problem that the auto fire mode cannot be set by `setting.ini`
- Now if you set the ads_only to `off`, when you press `G`, the no-recoil effect will be removed (for grenade).

### 2021/10/03 version 1.1
- Support G7, Wingman auto fire mode
- Seperate recoil pattern to txt file (learn from [ApexAHK-Reduce-recoil](https://github.com/sayoui001/ApexAHK-Reduce-recoil)).
- Update recoil pattern (also copy from [ApexAHK-Reduce-recoil](https://github.com/sayoui001/ApexAHK-Reduce-recoil)).

### 2021/08/22
- update recoil pattern
- fix havoc turbocharger problem

### 2021/08/20
- support rampage
- update recoid pattern

### 2021/08/15
- fix p2020 menu problem and reformat code
- fix lstar recoil pattern problem

### Season 10 Update
- Support more weapon: Alternator, RE45, Hamlok, Prowler and P2020
- Hamlok's origial single fire mode is now autofire
- P2020 is now autofire
- Add fire mode detection, the script will do nothing in single fire mode for all weapon except Hamlok and P2020
- change the recoil pattern struct to support changing interval between each shot.

## How to modify the code
All the ahk src file is now more to `/src`. You need to have AutoHotKey pre-installed on your computer if you want to run the `apexmaster.ahk` file directly. 

When debuging, you can uncomment `%hint_method%(current_weapon_type)`. This would tell you which weapon you are holding while the detection logic works.

For people who want support for more resolutions, check this video: [Apex-NoRecoil-2021 AHK | Customized Resolution](https://www.youtube.com/watch?v=VhpEi4_U3lc).

## Credit

I learn a lot from [thyaguster/NoRecoilApex](https://github.com/thyaguster/NoRecoilApex). But his code is pretty bad. There are thousands of lines of duplicated code in that repo. And some of the logic is wrong. (e.g. sleep twice to get the accuracy. Why not double the sleep value). So I make my own. Their code is about three thousand lines, but mine is only about 350, which comes with auto-weapon-detection.

From version 1.1, the pattern is "stolen" from sayoui001's repo -- [ApexAHK-Reduce-recoil](https://github.com/sayoui001/ApexAHK-Reduce-recoil). The features we provided are pretty much the same lol. The mainly difference is the detection logic. 

