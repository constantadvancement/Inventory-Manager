#!/usr/bin/env bash

# Exits if this script is not executed as root
if [ "$EUID" -ne 0 ]; then 
        echo "Please run as root!"
        exit
fi

username="$1"
fullname="$2"
password="$3"

# Exits if missing arguments
if [ -z "$username" ]; then
    echo "Missing argument: username"
    exit 0
elif [ -z "$fullname" ]; then
    echo "Missing argument: fullname"
    exit 0
elif [ -z "$password" ]; then
    echo "Missing argument: password"
    exit 0
fi

# Determines the next available UniqueID value
lastID=`dscl . -list /Users UniqueID | awk '{print $2}' | sort -n | tail -1`
nextID=$((lastID + 1))

# Creates the new user
dscl . -create /Users/$username
dscl . -create /Users/$username RealName "$fullname"
dscl . -passwd /Users/$username $password

dscl . -create /Users/$username UserShell /bin/bash

dscl . -create /Users/$username UniqueID $nextID
dscl . -create /Users/$username PrimaryGroupID 80

dscl . -create /Users/$username NFSHomeDirectory /Users/$username