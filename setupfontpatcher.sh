#!/usr/bin/env bash


echo "Setting up Termux-Ubuntu"

apt update && apt upgrade

apt install fontforge git -y

git clone https://github.com/johnfawkes/android_font_patcher.git

cd android_font_patcher

chmod a+x fixfonts.sh

mkdir -p /sdcard/Fontchanger/Patcher 2>&1

echo "Please place your fonts in internal storage/Fontchanger/Patcher"

exit 0 

