<p  align="center"><img  src="https://res.cloudinary.com/wemakeart/image/upload/v1629200112/apex-no-recoil/apex-no-recoil_pdavbo.jpg"  width=500px  height="100px" /></p>

## APEX NO-RECOIL

A CLI based tool written in Python that helps to control recoil as much as possible with the use of recoil patterns. This is still a WIP so feedback and possible help especially with fine-tuning the recoil patterns would be appreciated.

## USAGE

1. Setup a virtual environment and install all packages in the requirements.txt file
2. Download  and install the Tesseract program here - [link](https://digi.bib.uni-mannheim.de/tesseract/tesseract-ocr-w64-setup-v5.0.0-alpha.20210811.exe)
3. Update **line 12** in **main.py** with the dir to where you installed the **tesseract.exe**
4. You should now be able to run the program in your venv using command - `py main.py`

## PATTERN-TRACKER TOOL

**Note** - The tool can be found in the *modules* dir as *pattern_tracker.py*
1. In the Apex Firing Range, choose your weapon of choice and find a flat wall.
2. Stand as far away from the wall as possible while still being able to see the bullet impacts.
3. ADS and empty the clip into the wall.
4. Come out of ADS and screenshot the wall.
5. Open the screenshot in MS Paint.
6. Run the tool - `py pattern_tracker.py`
7. Enable the tool and click on the bullet impacts starting from the bottom working upwards.
8. Once completed, save your recoil-pattern and the `*.txt` file should be in the dir where the tool was run.
9. The pattern in the `*.txt` file can then be imported in the *recoil_patterns.py* file.

## CONFIG FILE

The following values are now more easily editable by the user from within the **config.yaml** file:

* Weapon slot scan position and dimensions
* Recoil-Pattern sensitivity modifier

The weapon slot scan position sets where the program scans for the names of the weapons you are using. The recoil-pattern sensitivity modifier adjusts the "strength" of the anti-recoil behavior, meaning a higher value applies less anti-recoil.

**IMPORTANT**
* When creating a recoil-pattern for the AHK script the fire-rate delay must be an integer | Ex. - 200
* When creating a recoil-pattern for the Python program the fire-rate delay must be a float | Ex. - 0.0200 

## SUPPORTED WEAPONS

| Weapon | Status |
| ------------- | ------------- |
| Sentinel | ❌ |
| P2020 | ✅ |
| Charge Rifle | ❌ |
| Longbow | ❌ |
| G7 SCOUT | ❌ |
| RE-45 | ✅ |
| Flatline | ✅ |
| Hemlok | ✅ |
| Prowler | ✅ |
| Wingman | ❌ |
| 30-30 Repeater | ❌ |
| Rampage | ❌ |
| L-Star | ✅ |
| Havoc | ✅ |
| Devotion | ✅ |
| Volt | ✅ |
| Bocek | ❌ |
| Kraber | ❌ |
| Triple Take | ❌ |
| Alternator | ✅ |
| Spitfire | ✅ |
| Mastif | ❌ |
| EVA-8 Auto | ❌ |
| Peacekeeper | ❌ |
| Mozambique | ❌ |

## 🚧WORK-IN-PROGRESS🚧

Future planned updates:

* Support for single-shot weapons
* Repeat-Fire for single-shot weapons
* Recoil-Pattern tool to help ease the process of updating recoil patterns ✅
* Adaptive sensitivity for different environments ✅
* Customizable weapon slot scan locations ✅