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

## Change Log
see: [change_log](change_log.md)

## How to modify the code
All the ahk src file is now more to `/src`. You need to have AutoHotKey pre-installed on your computer if you want to run the `apexmaster.ahk` file directly. 

When debuging, you can uncomment `%hint_method%(current_weapon_type)`. This would tell you which weapon you are holding while the detection logic works.

For people who want support for more resolutions, check this video: [Apex-NoRecoil-2021 AHK | Customized Resolution](https://www.youtube.com/watch?v=VhpEi4_U3lc).

## Credit

I learn a lot from [thyaguster/NoRecoilApex](https://github.com/thyaguster/NoRecoilApex). But his code is pretty bad. There are thousands of lines of duplicated code in that repo. And some of the logic is wrong. (e.g. sleep twice to get the accuracy. Why not double the sleep value). So I make my own. Their code is about three thousand lines, but mine is only about 350, which comes with auto-weapon-detection.

The approach I used to generate recoil patterns is from (vengefulcrop)[https://github.com/vengefulcrop/AE-Recoil-Pattern-Generation/].
