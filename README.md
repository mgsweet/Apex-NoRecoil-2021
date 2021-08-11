# Apex-NoRecoil-2021
An AutoHotKey script to minimize recoil with auto weapon detection for Apex Legends. (Only works on 1080p). 

Apex Legends AHK 压枪宏，带武器自动检测. (只支持 1080p)

## Description
This repository contains an Autohotkey script to help you minimize weapon recoil. Your weapon is auto-detected by the script (no need to press the F key anymore! XD). The detection is based on a straightforward and naive strategy (I call it three-pixel-detection). It is pretty safe because all it does is just capture some pixels and then use mouse DllCall to move your mouse. Run the compiled version if you want more protection. Current support weapon: R99, R301, RE45, Flatline, Spitfire, Havoc, Volt, Devotion, L-Star, Hamlok, Prowler and Alternator.

该库包含了一个带自动武器检测的 Apex Legends 压枪宏，不读内存，不注入游戏文件，纯粹就是识别像素颜色并帮助你移动鼠标，不会封号（这就类似于那些淘宝卖好几百的主播专用压枪宏）。目前支持枪械包括 R99, R301, RE45, Alternator, Flatline, Spitfire, Havoc, Volt, Devotion, L-Star, Hamlok 和 Prowler.

## Season 10 Update
- Support more weapon: Alternator, RE45, Hamlok and Prowler. 支持更多武器
- Hamlok's origial single fire mode is now autofire. 汉姆洛克的单点模式现在是全自动
- Add fire mode detection, the script will do nothing in single fire mode for all weapon except Hamlok. 现在半自动模式除了汉姆洛克不再提供补偿
- change the recoil pattern struct to support changing interval between each shot. 现在支持每枪的补偿间隔设置

## Usage
The default mouse sensitivity is `5.0`. Change the sens in `settings.ini` to yours.

You need to have AutoHotKey pre-installed on your computer if you want to run the `apexmaster.ahk` file directly.

Otherwise, you can just use the `apexmaster.exe` file in the `/bin`.

After running the script, every time you press `1`, `2`, `B` or `E`, the script will detect your current weapon and provide compensation while you click `L Button` while holding your `R Button`. It cannot detect the weapon when you get one by "licking a dead player's box"(I haven't done this yet). But once you click any of the four buttons mention above, the detection should work :)

默认鼠标灵敏度为 `5.0` ，可以通过改动 `settings.ini` 下的 `sen` 更改。想要直接运行 `apexmaster.ahk` 的话你需要另外安装AutoHotKey。如果不想安装 AutoHotKey，理论上直接跑 `/bin` 目录下的 `apexmaster.exe` 也是没问题的。武器检测会在你按 `1`, `2`, `B` 或 `E` 时进行，舔包时通过鼠标点击获得的武器在一开始不会被检测，但在你按下上面所述四个按钮中任意一个后武器压枪补偿就会更新。

## How to guide
If you want to compile the script, you need to uncomment [line 373](https://github.com/mgsweet/Apex-NoRecoil-2021/blob/65b3f2e9e623652597be86cff00af7ab862b10f7/apexmaster.ahk#L373) and comment [line 372](https://github.com/mgsweet/Apex-NoRecoil-2021/blob/65b3f2e9e623652597be86cff00af7ab862b10f7/apexmaster.ahk#L372).

## Contributing
It would be good if you can help me setup some more accurate recoil value or make the script support more weapons. Check the code and send me a pull request if you do so. I really appreciate that. 

目前补偿还不是特别精确，因为调试的过程比较枯燥。我希望有朋友可以帮我调试相应的补偿或提供更多枪械的检测。欢迎大家给我发 pull request。谢谢！

## Credit
I learn a lot from [thyaguster/NoRecoilApex](https://github.com/thyaguster/NoRecoilApex). But his code is pretty bad. There are thousands of lines of duplicated code in that repo. And some of the logic is wrong. (e.g. sleep twice to get the accuracy. Why not double the sleep value). So I make my own. Their code is about three thousand lines, but mine is only about 350, which comes with auto-weapon-detection. I didn't write the GUI to help to change the mouse sensitivity yet. You can send me a pull request if you do so.
