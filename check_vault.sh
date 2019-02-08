#!/bin/bash

# Get all arguments that where passed to git push
ARGUMENTS=`echo "$@"`

# Preparing variables
WD=`pwd`
SEARCH='$ANSIBLE_VAULT;'
SOMETHINGISWRONG=0
NC='\033[0m'
RED='\033[0;31m'
GREEN='\033[0;32m'
FILES=()
declare -a TYPES
# Add more naming pattern to check those too
TYPES=('*vault*' '*.keytab' '*.pem' '*.jks')

# Find all files with matching naming convention
for i in ${TYPES[@]}; do
  for i in `find -L $WD -iname "$i" -type f`; do
    FILES+=($i)
  done
done

# Check each file that contains vault in its name
for i in ${FILES[@]} ; do
  # Ignore empty files
  META=`file $i | awk '{print $2}'`
  if [[ $META != "empty" ]]; then
    # Check if first line contains "$ANSIBLE_VAULT;"
    LINE=`head -n 1 $i`
    if [[ $LINE == *"$ANSIBLE_VAULT;"* ]]; then
      NAME=`echo $i | sed 's/.*\///'`
      printf "${GREEN}$NAME is encrypted.${NC}\n"
    else
      NAME=`echo $i | sed 's/.*\///'`
      printf "${RED}$NAME is unencrypted.${NC}\n"
      SOMETHINGISWRONG=1
    fi
  fi
done

if [[ $SOMETHINGISWRONG -eq 1 ]]; then
  echo "Sensetive files that are unencrypted found!"
  while true; do
    read -p "Do you wish to commit anyways? (yY/nN) " answer
    case $answer in
        [yY]* ) git commit $ARGUMENTS;break;;
        [nN]* ) exit;;
        * ) echo "Please answer yes (y/Y) or no (n/N).";;
    esac
  done
else
  git commit $ARGUMENTS
fi
