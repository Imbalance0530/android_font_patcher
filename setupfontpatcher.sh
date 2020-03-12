#!/usr/bin/env bash


echo "Setting up Termux-Ubuntu"

sudo apt update && sudo apt upgrade

sudo apt install fontforge git -y

git clone https://github.com/johnfawkes/android_font_patcher.git

cd android_font_patcher

chmod a+x fixfonts.sh

mkdir /sdcard/Fontchanger/Patcher

echo "Please place your fonts in internal storage/Fontchanger/Patcher"

exit 0 

