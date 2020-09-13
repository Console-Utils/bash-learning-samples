declare -r -i width=15

for background in {40..47} {100..107} 49
do
  printf "\e[${background}m %-${width}s \e[0m\n" "color code=${background}m"
done
