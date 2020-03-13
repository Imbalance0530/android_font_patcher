# FONTPATCHER

Font patcher script by nongthaihoang @ xda.
Wrapper script by John Fawkes

Patch custom fonts to be used on Android.

## What it does?
- Fix missing glyphs.
- Fix misaligned glyphs.
- Fix kerning.
- Fix ligatures.
- Fix font name.
- Fix missing lockscreen colon

## Requirements
- Linux
- Android with termux and ubuntu
- Fontforge

## TODO
- Add way to match weight of font with style of font. ( ie. bold actually displays bold font )

## Usage
Step 1:
- Install Termux from Play Store
Step 2:
- Run the following command in termux to update
  ```
  pkg update && pkg upgrade
  ```
Step 3:
- Installing Ubuntu
  ```
  pkg update -y && pkg install proot wget tar pulseaudio -y && wget https://raw.githubusercontent.com/JohnFawkes/android_font_patcher/master/ubuntu19.sh && chmod a+x ubuntu19.sh && ./ubuntu19.sh
  ```
Step 4:
- Starting Ubuntu
  ```
  startubuntu
  ```
Step 5:
- Installing the Font Patcher
  ```
  wget https://raw.githubusercontent.com/JohnFawkes/android_font_patcher/master/setupfontpatcher.sh && chmod a+x setupfontpatcher.sh && ./setupfontpatcher.sh
  ```
Step 6:  
- Preparing to patch  
  ( /sdcard == Internal Storage )  
  - Navigate to /sdcard/Fontchanger/Patcher and create a folder for each font  
  - Place your single ttf inside  
  - Folder structure will be:  
      |--sdcard/  
        |--Fontchanger/  
          |--Patcher/  
            |--<Folder with Font Name>/  
              |--<single ttf>, can be named anything  
Step 7:  
- Patching!  
  ```
  ./fixfonts.sh  
  ```
  - Follow the on screen prompts  
Step 8:  
- Once patching is done font folder are auto copied to /sdcard/Fontchanger/Fonts/Custom  
- You'll be able to exit from ubuntu with ```exit``` then ```su``` ```font_changer```  
Step 9:  
- ENJOY!!  
  


