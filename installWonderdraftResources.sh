#!/bin/bash
# Example of simply copying from a local directory called /Wonderdraft which contains /assets, /maps, and /themes 
# and recursively copies them up to the specified local paths in your wonderdraft.config file.

# Purpose is to allow all custom assets, maps, and themes to be source controlled and available across multiple OS types.

# This script expects to live and be executed from the project root.
# wonderdraft.config file should also live at the project root.
# You may need to grant permission to execute this script by your OS (`chmod 755 ./installWonderdraftResources.sh` in Linux/Mac, etc..)

# Supports Linux, MacOS, and Windows

#################################

# Get current directory in bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

# Source in our paths from the config file
. $DIR/wonderdraft.config

# Define some colors
RED='\e[1;31m'
GREEN='\e[1;32m'
YELLOW='\e[1;33m'
BLUE='\e[1;34m'
NC='\e[0m'

printf "${YELLOW}\nPreparing to copy Wonderdraft assets, maps, themes.\n${NC}"
printf "${YELLOW}\nOperating System type discovered is: ${BLUE}... $OSTYPE${NC}\n"
printf "${YELLOW}\nCurrent Directory: $DIR\n${NC}"

if [[ "$OSTYPE" == "linux-gnu" ]]; then
  # Linux OS
  printf "${YELLOW}\nTarget Directory: $wonderdraftLinuxUserDirectoryPath\n${NC}"
  cp -a $DIR/novel/maps/Wonderdraft/. "$wonderdraftLinuxUserDirectoryPath"
elif [[ "$OSTYPE" == "darwin"* ]]; then
  # Mac OS
  printf "${YELLOW}\nTarget Directory: $wonderdraftMacUserDirectoryPath\n${NC}"
  rsync --progress -r $DIR/novel/maps/Wonderdraft/* "$wonderdraftMacUserDirectoryPath"
elif [[ "$OSTYPE" == "cygwin" ]]; then
  # POSIX compatibility layer and Linux environment emulation for Windows
  printf "${YELLOW}\nTarget Directory: $wonderdraftWindowsUserDirectoryPath\n${NC}"
  robocopy "$DIR\novel\maps\Wonderdraft" "$wonderdraftWindowsUserDirectoryPath" /e
elif [[ "$OSTYPE" == "msys" ]]; then
  # Lightweight shell and GNU utilities compiled for Windows (part of MinGW)
  printf "${YELLOW}\nTarget Directory: $wonderdraftWindowsUserDirectoryPath\n${NC}"
  robocopy "$DIR\novel\maps\Wonderdraft" "$wonderdraftWindowsUserDirectoryPath" /e
elif [[ "$OSTYPE" == "win32" ]]; then
  # I'm not sure this can happen.
  printf "${YELLOW}\nTarget Directory: $wonderdraftWindowsUserDirectoryPath\n${NC}"
  robocopy "$DIR\novel\maps\Wonderdraft" "$wonderdraftWindowsUserDirectoryPath" /e
elif [[ "$OSTYPE" == "freebsd"* ]]; then
  printf "${RED}FreeBSD OS is NOT SUPPORTED for copying Wonderdraft assets, maps, themes\n${NC}"
  exit 1
else
  printf "${RED}Unknown Operating System; Cannot copy Wonderdraft assets, maps, themes\n${NC}"
  exit 1
fi

printf "${GREEN}Copy complete.\n${NC}"
exit 0