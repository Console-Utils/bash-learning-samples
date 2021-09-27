#!/usr/bin/env bash

for foreground in {30..37} {90..97} 39
do
  printf "\e[${foreground}m %s \e[0m\n" "color code=${foreground}m"
done
