# Apex-NoRecoil-2021
An AutoHotKey script to minimize recoil with auto weapon detection for Apex Legends. (Only works on 1080p). Apex Legends AutoHotKey 压枪宏，带武器自动检测.

## Description
This repository contains an Autohotkey script to help you minimize weapon recoil. Your weapon is auto-detected by the script (no need to press F key any more!XD). The detection is based on very simple and naive strategy (I call it three-pixel-detection) It is pretty safe because all it does is just capture some pixels and then use mouse DllCall to move your mouse. Run the compiled version if you want more protection.

## Usage
The default mouse sensitivity is `5.0`. Change the `sens` in `settings.ini` to yours.

You need to have AutoHotKey pre-installed in your computer if you want to run the `apexmaster.ahk` file directly.

Otherwise, you can just use the `apexmaster.exe` file in the `/bin`.

After you run the script, every time you press `1`, `2` or `E`, the script will detect your current weapon and will provide compensation while you click `L Button` while holding your `R Buttion`.

## How to guide
If you want to compile the script, you need to uncomment [line 295](https://github.com/mgsweet/Apex-NoRecoil-2021/blob/65b3f2e9e623652597be86cff00af7ab862b10f7/apexmaster.ahk#L295) and comment [line 294](https://github.com/mgsweet/Apex-NoRecoil-2021/blob/65b3f2e9e623652597be86cff00af7ab862b10f7/apexmaster.ahk#L294).

## Contributing
It would be good if you can help me setup some more accurate recoil value or make the script support more weapons. Check the code and send me a pull request if you do so. I really appreciate that. 

## Credit
I learn a lot from [thyaguster/NoRecoilApex](https://github.com/thyaguster/NoRecoilApex). But his code is pretty bad. There are thousand lines of duplicated code in that repo. And some of the logic there is wrong. (e.g. sleep twice to get the accuracy...why not double the sleep value). So I make my own. Their code is about three thousand lines but my one is only about 350, which comes with auto-weapon-detection. I didn't write the gui to help changing the mouse sensitivity yet. You can send me a pull request if you do so.
