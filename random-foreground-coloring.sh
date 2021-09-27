#!/usr/bin/env bash

declare -a colors=({30..37} {90..97} 39)
declare -i colorsLength=${#colors[@]}

text="Hello World!"
textLength=${#text}

for i in $(seq 0 $(($textLength - 1)))
do
  declare -i j=$((RANDOM % colorsLength))
  echo -e -n "\e[${colors[j]}m${text:i:1}\e[0m"
done
echo
