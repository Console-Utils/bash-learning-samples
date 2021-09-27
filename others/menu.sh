#!/usr/bin/env bash

# Call syntax: getMaxLength <items>
function getMaxLength()
{
  local value=$1
  local -i max=${#value}
  shift

  while [[ -n $1 ]]
  do
    value=$1
    (( "${#value}" > max )) && max=${#value}
    shift
  done

  echo $max
}

# Call syntax: drawMenu --selected|-s <index> --foreground|-f <foreground> --background|-b <background> -- <items>
function drawMenu()
{
  local -ir UnexpectedEndOfArgumentList=1
  local -ir UnrecognizedOptionInArgumentList=2
  local -ir SelectedLessThanZero=3
  local -ir SelectedExceedsItemCount=4

  local -ir DefaultForeground=37
  local -ir DefaultBackground=40

  while [[ -n $1 ]]
  do
    local option=$1
    local value=$2

    case $option in
      --selected|-s)
          local -i selected=$value
          shift 2 || return $UnexpectedEndOfArgumentList
        ;;
      --foreground|-f)
          local -i foreground=$value
          shift 2 || return $UnexpectedEndOfArgumentList
        ;;
      --background|-b)
          local -i background=$value
          shift 2 || return $UnexpectedEndOfArgumentList
        ;;
      --)
          shift
          break
        ;;
      *)
          return $UnrecognizedOptionInArgumentList
        ;;
    esac
  done

  local values=()
  local value=$1
  while [[ -n $1 ]]
  do
    values+=("$1")
    shift
  done

  (( selected < 0 )) && return $SelectedLessThanZero
  (( selected > "${#values[@]}" - 1 )) && return $SelectedExceedsItemCount

  local -i max=$(getMaxLength "${values[@]}")

  local -i i=0
  for value in "${values[@]}"
  do
    local placeholder="$(printf " %0.0s" $(seq 0 $(($max - ${#value}))))"
    (( selected == i )) && underline='4;' || underline=''
    echo -e "\e[${underline}${foreground};${background}m$value${placeholder:1}\e[0m"
    ((i++))
  done
}

# Call syntax: selectMainMenu
function selectMainMenu()
{
  local items=(Add Replace Remove)
  local -i foreground=37
  local -i background=44
  local -i selected=0

  drawMenu --selected $selected --foreground $foreground --background $background -- "${items[@]}"

  read -sr -n 1 char
  while [[ $char != 'e' ]]
  do
    case $char in
      'w')
          ((selected--))
          (( selected < 0 )) && selected=0
        ;;
      's')
          ((selected++))
          (( selected > "${#items[@]}" - 1 )) && selected="${#items[@]} - 1"
        ;;
      'q')
          clear
          case $selected in
          0)
              selectAddMenu
            ;;
          1)
              selectReplaceMenu
            ;;
          2)
              selectRemoveMenu
            ;;
          esac
        ;;
      *)
        ;;
    esac
    echo -ne "\e[${#items[@]}A"
    drawMenu --selected $selected --foreground $foreground --background $background -- "${items[@]}"
    read -sr -n 1 char
  done
}

# Call syntax: selectAddMenu
function selectAddMenu()
{
  local items=("Yes, add" "No, cancel")
  local -i foreground=37
  local -i background=46
  local -i selected=0

  drawMenu --selected $selected --foreground $foreground --background $background -- "${items[@]}"

  read -sr -n 1 char
  while [[ $char != 'e' ]]
  do
    case $char in
      'w')
          ((selected--))
          (( selected < 0 )) && selected=0
        ;;
      's')
          ((selected++))
          (( selected > "${#items[@]}" - 1 )) && selected="${#items[@]} - 1"
        ;;
      'q')
          clear
          case $selected in
            0)
              ;;
            1)
                return
              ;;
          esac
        ;;
      *)
        ;;
    esac
    echo -ne "\e[${#items[@]}A"
    drawMenu --selected $selected --foreground $foreground --background $background -- "${items[@]}"
    read -sr -n 1 char
  done
}

# Call syntax: selectReplaceMenu
function selectReplaceMenu()
{
  local items=("Yes, replace" "No, cancel")
  local -i foreground=37
  local -i background=46
  local -i selected=0

  drawMenu --selected $selected --foreground $foreground --background $background -- "${items[@]}"

  read -sr -n 1 char
  while [[ $char != 'e' ]]
  do
    case $char in
      'w')
          ((selected--))
          (( selected < 0 )) && selected=0
        ;;
      's')
          ((selected++))
          (( selected > "${#items[@]}" - 1 )) && selected="${#items[@]} - 1"
        ;;
      'q')
          clear
          case $selected in
            0)
              ;;
            1)
                return
              ;;
          esac
        ;;
      *)
        ;;
    esac
    echo -ne "\e[${#items[@]}A"
    drawMenu --selected $selected --foreground $foreground --background $background -- "${items[@]}"
    read -sr -n 1 char
  done
}

# Call syntax: selectRemoveMenu
function selectRemoveMenu()
{
  local items=("Yes, remove" "No, cancel")
  local -i foreground=37
  local -i background=46
  local -i selected=0

  drawMenu --selected $selected --foreground $foreground --background $background -- "${items[@]}"

  read -sr -n 1 char
  while [[ $char != 'e' ]]
  do
    case $char in
      'w')
          ((selected--))
          (( selected < 0 )) && selected=0
        ;;
      's')
          ((selected++))
          (( selected > "${#items[@]}" - 1 )) && selected="${#items[@]} - 1"
        ;;
      'q')
          clear
          case $selected in
            0)
              ;;
            1)
                return
              ;;
          esac
        ;;
      *)
        ;;
    esac
    echo -ne "\e[${#items[@]}A"
    drawMenu --selected $selected --foreground $foreground --background $background -- "${items[@]}"
    read -sr -n 1 char
  done
}

tput civis
clear
selectMainMenu
