# Android Font Patcher
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
- Android with termux and a linux distro
- Fontforge

## Usage
- Clone the repo:
  ```
  git clone https://github.com/johnfawkes/android_font_patcher.git
  cd android_font_patcher
  ```
- Rename your fonts to match styles with Roboto:

  `*-<STYLE>.<extension>`

  `STYLE`: Thin | ThinItalic | Light | LightItalic | Regular | Italic
  | Medium | MediumItalic | Bold | BoldItalic | Black | BlackItalic
  
  `Condensed Styles`: Bold | BoldItalic | Italic | Light |LightItalic | Medium | MediumItalic | Regular

- Run command:
  ```
  ./fixfonts
  ```
 
- The generated fonts will be named after Roboto and placed in the same folder as your fonts.

## Android

- Requirements:
  - Termux
    Step 1: Install termux and run 
    ```
    pkg update && pkg upgrade
    ```
    Step 2: Install git, curl, bsdtar and proot with 
    ```
    pkg install curl
    pkg install proot
    pkg install bsdtar
    pkg install git
    ```
    Step 3: Install Arch
    ```
    curl -OL https://raw.githubusercontent.com/TermuxArch/TermuxArch/master/setupTermuxArch.bash
    ```
    ```
    chmod a+x setupTermuxArch.bash
    ```
    ```
    bash setupTermuxArch.bash
    ```
    Step 4: Wait for Arch to install. Could take up to a half hour
    after its done type exit to exit out of arch
    
    Step 5: Using font-patcher
    ```
    git clone https://github.com/johnfawkes/android_font_patcher.git
    ```
    change to patcher folder
    ```
    cd android_font_patcher
    ```
    ```
    cd Fonts
    ```
    Step 6: Run Arch
    ```
    startarch
    ```
    Install FontForge
    ```
    pacman -S fontforge
    ```
    Step 7: Rename and copy fonts
    Place your single ttf in your internal storage in a folder with the name of your font. 
    Copy and paste the ttf 19 times so that you have 20 files.
    Rename then in the roboto format. ( ex. Roboto-style.extension )
    The styles you need to rename them as are listed above.
    use cp to copy your fonts to the Fonts folder. ( sdcard == internal storage )
    If you dont use cp and use a file explorer then the permissions will be wrong!
    Ex. cp -r /sdcard/<name of font folder> $PWD
    Give execute perms for the script
    ```
    cd ../
    chmod a+x fixfonts.sh
    ```
    run the wrapper script with
    ```
    ./fixfonts.sh
    ```
    then follow the onscreen options or run ./fixfonts.sh --help 
    Step 8: Run FontChanger
    Copy and paste the font folder from /data/data/com.termux/files/home/android_font_patcher/Fonts/<name of font> to 
    internal storage/Fontchanger/Fonts/Custom.
    Then run font_changer in terminal and choose fonts then custom and select your font.
    
## Issues on Android

* If when you run the patcher fontforge complains about save error, Generated save error, then make sure you use cp to move the fonts from one directory to the Fonts folder inside of android_font_patcher!
