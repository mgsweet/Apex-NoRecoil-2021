# Apex-NoRecoil-2021
<!-- ALL-CONTRIBUTORS-BADGE:START - Do not remove or modify this section -->
[![All Contributors](https://img.shields.io/badge/all_contributors-5-orange.svg?style=flat-square)](#contributors-)
<!-- ALL-CONTRIBUTORS-BADGE:END -->
An AutoHotKey script (works on multiple resolutions) and Python CLI (works on 1080p) to minimize recoil with auto weapon detection for Apex Legends. 

Apex Legends 压枪宏，带武器自动检测，包含了一个ahk的版本 (支持多分辨率) 和一个python的版本 (只支持 1080p) 。

## Warning 警告
Respawn may updated their cheating detection strategy, and we am still doing some testing. The reason for the current ban is not yet clear. Maybe is time to archive the whole project:(

## AHK Script - Description 介绍
This repository contains an Autohotkey script to help you minimize weapon recoil. Your weapon is auto-detected by the script (no need to press the F key anymore! XD). The detection is based on a straightforward and naive strategy (I call it three-pixel-detection). It is pretty safe because all it does is just capture some pixels and then use mouse DllCall to move your mouse. Run the compiled version if you want more protection. 

该库包含了一个带自动武器检测的 Apex Legends 压枪宏，不读内存，不注入游戏文件，纯粹就是识别像素颜色并帮助你移动鼠标（这就类似于那些淘宝卖好几百的主播专用压枪宏）。

### [AHK Script - Details and Usage 详细使用指南](https://github.com/mgsweet/Apex-NoRecoil-2021/tree/main/AHK)

- Pros
  - comes with GUI 有圖形界面
  - support multiple resolution settings 支持多種分辨率
  - simple 简单
  - out of the box 开箱即用
  - support different language setting in game 支持不同的游戏语言设置
- Cons
  - too many magic pixel position 太多神奇的像素位置设定
  - need lots of modification to support other resolution 很难去支持别的分辨率
  - not many people know how to code with AHK, not DIY friendly 脚本编程语言小众

## Python CLI - Description 介绍
The repository also contains a Python version of the AHK script. It uses the Google Tesseract OCR and OpenCV to detect the weapon being used via key listener. The recoil-patterns are applied via win32api mouse_event. The program was built to be consumed as a CLI. The Python dir also contains a recoil-pattern creation tool which can be found in the modules dir. For more info please read the README in the python dir.

该库也包含了一个有着相似功能的 Python 脚本。这个脚本使用到了 Google Tesseract OCR 和 OpenCV 技术并通过监测键盘输入去进行武器检测。这个脚本主要通过命令行交互界面进行操作。

### [Python CLI - Details and Usage 详细使用指南](https://github.com/mgsweet/Apex-NoRecoil-2021/tree/main/python)

- Pros
  - DIY friendly 客制化容易
  - Cool CLI 好看的命令行界面
  - Smart detection strategy 更为智能的武器检测策略
- Cons
  - detection based on OCR, only support English charactor 只支持英文游戏界面
  - currently don't have as much as features as the AHK one 目前功能没有ahk版本那么多

## Unknown Cheat thread 
I post a [thread](https://www.unknowncheats.me/forum/apex-legends/476508-apex-norecoil-2021-official-post-auto-detect-multiple-resolution-supported.html) there too, to let more people know the script.

## Contributing
It would be good if you can help me setup some more accurate recoil value or make the script support more weapons. Check the code and send me a pull request if you do so. I really appreciate that. 

目前补偿还不是特别精确，因为调试的过程比较枯燥。我希望有朋友可以帮我调试相应的补偿或提供更多枪械的检测。欢迎大家给我发 pull request。谢谢！

## Contributors
<table>
  <tr>
<!-- ALL-CONTRIBUTORS-LIST:START - Do not remove or modify this section -->
<!-- prettier-ignore-start -->
<!-- markdownlint-disable -->
<table>
  <tr>
    <td align="center"><a href="http://mgsweet.com"><img src="https://avatars.githubusercontent.com/u/15327389?v=4?s=100" width="100px;" alt=""/><br /><sub><b>Aaron Yau</b></sub></a><br /><a href="https://github.com/mgsweet/Apex-NoRecoil-2021/commits?author=mgsweet" title="Code">💻</a></td>
    <td align="center"><a href="https://www.wemakeart.co.za"><img src="https://avatars.githubusercontent.com/u/21266436?v=4?s=100" width="100px;" alt=""/><br /><sub><b>Brandon Williams</b></sub></a><br /><a href="https://github.com/mgsweet/Apex-NoRecoil-2021/commits?author=krampus-nuggets" title="Code">💻</a></td>
    <td align="center"><a href="https://github.com/filen1"><img src="https://avatars.githubusercontent.com/u/88589472?v=4?s=100" width="100px;" alt=""/><br /><sub><b>filen1</b></sub></a><br /><a href="#data-filen1" title="Data">🔣</a></td>
    <td align="center"><a href="https://github.com/sayoui001"><img src="https://avatars.githubusercontent.com/u/89756686?v=4?s=100" width="100px;" alt=""/><br /><sub><b>sayoui001</b></sub></a><br /><a href="https://github.com/mgsweet/Apex-NoRecoil-2021/commits?author=sayoui001" title="Code">💻</a></td>
    <td align="center"><a href="https://github.com/SiLeNT-Sooul"><img src="https://avatars.githubusercontent.com/u/72454428?v=4?s=100" width="100px;" alt=""/><br /><sub><b>SiLeNT-Sooul</b></sub></a><br /><a href="#data-SiLeNT-Sooul" title="Data">🔣</a></td>
  </tr>
</table>

<!-- markdownlint-restore -->
<!-- prettier-ignore-end -->

<!-- ALL-CONTRIBUTORS-LIST:END -->
</table>
