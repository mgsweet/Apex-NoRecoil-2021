# Apex-NoRecoil-2021 - AHK
An AutoHotKey script to minimize recoil with auto weapon detection for Apex Legends. (Only works on 1080p). 

Apex Legends 压枪宏，带武器自动检测，只支持 1080p 无边框全屏模式。

## Description
This repository contains an Autohotkey script to help you minimize weapon recoil. Your weapon is auto-detected by the script (no need to press the F key anymore! XD). The detection is based on a straightforward and naive strategy (I call it three-pixel-detection). It is pretty safe because all it does is just capture some pixels and then use mouse DllCall to move your mouse. Run the compiled version if you want more protection. Current support weapon: R99, R301, RE45, Flatline, Spitfire, Havoc, Volt, Devotion, L-Star, Hamlok, Prowler, Alternator and P2020.

该库包含了一个带自动武器检测的 Apex Legends 压枪宏，不读内存，不注入游戏文件，纯粹就是识别像素颜色并帮助你移动鼠标，不会封号（这就类似于那些淘宝卖好几百的主播专用压枪宏）。目前支持枪械包括 R99, R301, RE45, Alternator, Flatline, Spitfire, Havoc, Volt, Devotion, L-Star, Hamlok, Prowler and P2020.

## Update
### 2021/10/16 version 1.1.1
- Fix a problem that the auto fire mode cannot be set by `setting.ini`
- Now if you set the ads_only to `off`, when you press `G`, the no-recoil effect will be removed (for grenade).

### 2021/10/03 version 1.1
- Support G7, Wingman auto fire mode
- Seperate recoil pattern to txt file (learn from [ApexAHK-Reduce-recoil](https://github.com/sayoui001/ApexAHK-Reduce-recoil))
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

## Usage
The default mouse sensitivity is `5.0`. Change the sens in `settings.ini` to yours.

To run in a more safer mode, set `auto_fire` to `"off"` in `settings.ini`. This would remove the auto fire feature for single shot weapon like G7, P2020, etc.

To make the script work only in ads mode, set  `ads_only` to `"on"` in `settings.ini`.

You need to have AutoHotKey pre-installed on your computer if you want to run the `apexmaster.ahk` file directly.

Otherwise, you can just use the `apexmaster.exe` file in the `/bin`.

After running the script, every time you press `1`, `2`, `B`, `R` or `E`, the script will detect your current weapon and provide compensation while you click `L Button` while holding your `R Button`. It cannot detect the weapon when you get one by "licking a dead player's box"(I haven't done this yet). But once you click any of the four buttons mention above, the detection should work :)

默认鼠标灵敏度为 `5.0` ，可以通过改动 `settings.ini` 下的 `sen` 更改。

如果你不想要单发武器全自动的功能， 可以将 `settings.ini` 下 `auto_fire` 设置为 `off` （会更安全）。

如果你只想在 ADS 模式下触发压枪的功能，可以将 `settings.ini` 下 `ads_only` 设置为 `on`。

想要直接运行 `apexmaster.ahk` 的话你需要另外安装AutoHotKey。如果不想安装 AutoHotKey，理论上直接跑 `/bin` 目录下的 `apexmaster.exe` 也是没问题的。武器检测会在你按 `1`, `2`, `B`, `R` 或 `E` 时进行，舔包时通过鼠标点击获得的武器在一开始不会被检测，但在你按下上面所述四个按钮中任意一个后武器压枪补偿就会更新。

## How to guide
If you want to compile the script, you need to find the following two lines, comment the first line and then uncomment the second line.

```go
IniWrite, "apexmaster.ahk"`n, settings.ini, script configs, script_name
; IniWrite, "apexmaster.exe"`n, settings.ini, script configs, script_name
```

## Credit

I learn a lot from [thyaguster/NoRecoilApex](https://github.com/thyaguster/NoRecoilApex). But his code is pretty bad. There are thousands of lines of duplicated code in that repo. And some of the logic is wrong. (e.g. sleep twice to get the accuracy. Why not double the sleep value). So I make my own. Their code is about three thousand lines, but mine is only about 350, which comes with auto-weapon-detection. I didn't write the GUI to help to change the mouse sensitivity yet. You can send me a pull request if you do so.

From version 1.1, the pattern is "stolen" from sayoui001's repo -- [ApexAHK-Reduce-recoil](https://github.com/sayoui001/ApexAHK-Reduce-recoil). The features we provided are pretty much the same lol. The mainly difference is the detection logic. 

