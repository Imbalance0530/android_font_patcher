#!/usr/bin/env bash

#alias # clear='echo'
if [ ! -d PatcherLogs ]; then
  mkdir PatcherLogs
fi
exec 2>PatcherLogs/patcher-verbose.log
set -x 2>&1

rm -f $PWD/Fonts/placeholder

# cmd & spinner <message>
e_spinner() {
  PID=$!
  h=0; anim='-\|/';
  while [ -d /proc/$PID ]; do
    h=$(((h+1)%4))
    sleep 0.02
    printf "\r${@} [${anim:$h:1}]"
  done
}                        

invalid() {
  echo "Invaild Option..."
  sleep 3
  # clear
  menu
}

list_fonts() {
  echo "Loading fonts"
  num=2
  if [ -f $PWD/listoffonts.txt ] || [ -f $PWD/fontlist.txt ] || [ -f $PWD/choices.txt ]; then
    rm -f $PWD/listoffonts.txt >&2
    rm -f $PWD/fontlist.txt >&2
    rm -f $PWD/choices.txt >&2
  fi
  touch $PWD/fontlist.txt 
  touch $PWD/choices.txt
  echo "[1] Patch all fonts" >> $PWD/fontlist.txt
  for i in $(find "$PWD/Fonts/" -type d | sed 's#.*/##'); do
    sleep 0.1
    echo "[$num] $i" >> $PWD/fontlist.txt
    echo "$num" >> $PWD/choices.txt
    num=$((num + 1))
  done
}

roboto=(  
  Roboto-Black.ttf 
  Roboto-BlackItalic.ttf 
  Roboto-Bold.ttf 
  Roboto-BoldItalic.ttf 
  RobotoCondensed-Bold.ttf 
  RobotoCondensed-BoldItalic.ttf 
  RobotoCondensed-Italic.ttf 
  RobotoCondensed-Light.ttf 
  RobotoCondensed-LightItalic.ttf 
  RobotoCondensed-Regular.ttf 
  Roboto-Italic.ttf 
  Roboto-Light.ttf 
  Roboto-LightItalic.ttf 
  Roboto-Medium.ttf 
  Roboto-MediumItalic.ttf 
  Roboto-Regular.ttf 
  Roboto-Thin.ttf 
  Roboto-ThinItalic.ttf
)

copy_fonts() {
  c=0
  IFS=$'\n'
  font=/sdcard/Fontchanger/Patcher/*
  font2=$font/*
  for l in ${font[@]}; do
    mv -f $l Fonts
  done
  for i in ${roboto[@]}; do
#    if [ ! -d Fonts/$(basename ${font[@]}); then
#      mkdir -p Fonts/$(basename ${font[@]}) 2>&1
#    fi
    cp -f ${font2} $PWD/Fonts/$(basename $font)/${roboto[$c]}
    c=$((c+1))
  done
  unset IFS
}

menu() {
  fontstyle=none
  choice=""
  all=false
  if [ ! -d $PWD/Fonts ]; then
    echo "Fonts folder is not found! Creating...."
    echo "Please place fonts inside a folder with the name of font inside the fonts folder"
    mkdir $PWD/Fonts
    exit
  fi
  copy_fonts
  for j in $PWD/Fonts/*; do
    if [ -d $j ]; then
      list_fonts & e_spinner
      # clear
      cat $PWD/fontlist.txt
      break
    else
      echo "No Fonts Found"
      echo " "
      echo "Please place fonts inside a folder with the name of font inside the fonts folder"
      exit
    fi
  done
  wrong=$(cat $PWD/fontlist.txt | wc -l)
  echo "Which font would you like to patch?"
  echo " "
  echo "Please enter the corresponding number"
  echo " "
  echo "[CHOOSE] : "
  echo " "
  read -r choice
    if [[ $choice == "1" ]]; then
      all=true
    elif [[ -n ${choice//[0-9]/} ]]; then
      invalid
    else
      [ $choice -gt $wrong ] && invalid
    fi
    if [[ $all == "true" ]]; then
      ls $PWD/Fonts >> $PWD/listoffonts.txt
      choice2=($(cat $PWD/listoffonts.txt))
    else
      choice2="$(grep -w $choice $PWD/fontlist.txt | tr -d '[' | tr -d ']' | tr -d "$choice" | tr -d ' ')"
    fi
  # clear
  echo "Which style would you like to patch?"
  echo " "
  echo "[0] Thin"
  echo " "
  echo "[1] ThinItalic"
  echo " "
  echo "[2] Light"
  echo " "
  echo "[3] LightItalic"
  echo " "
  echo "[4] Regular"
  echo " "
  echo "[5] Italic"
  echo " "
  echo "[6] Medium"
  echo " "
  echo "[7] MediumItalic"
  echo " "
  echo "[8] Bold"
  echo " "
  echo "[9] BoldItalic"
  echo " "
  echo "[10] Black"
  echo " "
  echo "[11] BlackItalic"
  echo " "
  echo "[12] All"
  read -r style
  case $style in
    0) fontstyle=Thin ;;
    1) fontstyle=ThinItalic;;
    2) fontstyle=Light;;
    3) fontstyle=LightItalic;;
    4) fontstyle=Regular;;
    5) fontstyle=Italic;;
    6) fontstyle=Medium;;
    7) fontstyle=MediumItalic;;
    8) fontstyle=Bold;;
    9) fontstyle=BoldItalic;;
    10) fontstyle=Black;;
    11) fontstyle=BlackItalic;;
    12) all2=true; fontstyle=(Thin ThinItalic Light LightItalic Regular Italic Medium MediumItalic Bold BoldItalic Black BlackItalic);;
    *) invalid
  esac
  # clear
    for j in ${fontstyle[@]}; do
      for k in ${choice2[@]}; do
        echo "$i"
        echo "$j"
          . $PWD/font-patcher $PWD/Fonts/$k/Roboto-$j.*
        if [[ $j == "Bold" ]] || [[ $j == "BoldItalic" ]] || [[ $j == "Italic" ]] || [[ $j == "Light" ]] || [[ $j == "LightItalic" ]] || [[ $j == "Regular" ]]; then
          . $PWD/font-patcher -cn $PWD/Fonts/$k/RobotoCondensed-$j.*
        fi
      done
    done
  echo "Moving fonts to custom fontchanger folder"
  for i in $PWD/Fonts/*; do
    if [ -d /sdcard/Fontchanger/Fonts/Custom/$(basename $i) ]; then
      rm -rf /sdcard/Fontchanger/Fonts/Custom/$(basename $i)
    fi
    mv $i /sdcard/Fontchanger/Fonts/Custom
  done
  cp -rf PatcherLogs /sdcard/Fontchanger/
}

menu
exit $?

