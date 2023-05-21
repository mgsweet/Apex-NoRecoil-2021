# Change Logs
### 2023/05/21 version 1.3.12
- remove green.ahk
- change the gold optic feature's logic (still fucking buggy, may remove it totally in the future)  
- support Season 17 (thanks to [Eternal-Walnut](https://github.com/Eternal-Walnut))

### 2023/02/27 version 1.3.11 (thanks to [Eternal-Walnut](https://github.com/Eternal-Walnut), [richardzzp](https://github.com/richardzzp))
- add hotkey to switch active state.
- update gold optics to support all sniper.
- fix configs create.
- fix hemlok color problem.
- support new weapon: nemesis (2560x1440, 1280x720, 1920x1080 and 1680x1050).

### 2023/01/14 version 1.3.10
- fix hemlok autofire mode bug
- update patterns: hemlok, prowler
- update the selective fire logic

### 2023/01/07 version 1.3.9
- fix 1920*1080 turbo detection bug
- fix version in gui.ahk

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
