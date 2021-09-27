#!/usr/bin/env bash

declare -r -i width=3

for i in {1..9}
do
  for j in {1..9}
  do
    if ((i*j % 2 != 0))
    then
      declare color="\e[1;34m"
    else
      declare color="\e[4;91m"
    fi
    declare -i result=$((i*j))
    declare -i length=${#result}
    printf "%$((width - length))s" " "
    printf "${color}%i\e[0m" $result
  done
  printf "\n"
done
