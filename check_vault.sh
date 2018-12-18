#!/bin/bash

# Get all arguments that where passed to git push
ARGUMENTS=`echo "$@"`

# Preparing variables
WD=`pwd`
SEARCH='$ANSIBLE_VAULT;'
FILES=`find -L $WD -iname '*vault*' -type f`
SOMETHINGISWRONG=0
NC='\033[0m'
RED='\033[0;31m'
GREEN='\033[0;32m'

# Check each file that contains vault in its name
for i in $FILES ; do
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
  echo "There where unencrypted vault files found."
  while true; do
    read -p "Do you wish to push anyways? (yY/nN) " answer
    case $answer in
        [yY]* ) git push $ARGUMENTS;break;;
        [nN]* ) exit;;
        * ) echo "Please answer yes (y/Y) or no (n/N).";;
    esac
  done
else
  git push $ARGUMENTS
fi
