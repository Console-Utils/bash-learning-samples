#!/usr/bin/env bash

declare -i Y=0
declare -i XMin=1
declare -i XMax=10
declare SleepTime=0.1
Text="Hello world!"
declare -i DefaultColor=32

declare -i x=0
declare color=$DefaultColor

tput civis
clear
while true
do
  for x in $(seq $XMin $XMax)
  do
    echo -en "\e[${Y};${x}H\e[${color}m$Text\e[0m"
    sleep $SleepTime
    clear
  done
  for x in $(seq $XMax -1 $XMin)
  do
    echo -en "\e[${Y};${x}H\e[${color}m$Text\e[0m"
    sleep $SleepTime
    clear
  done
done
