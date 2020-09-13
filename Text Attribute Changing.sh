for attribute in 0 1 2 4 5 7 ; do
  printf "\e[${attribute}m %s \e[0m\n" "attribute code=${attribute}m"
done