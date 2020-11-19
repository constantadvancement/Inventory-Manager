#!/usr/bin/env bash

# Uninstaller script removes changes made to this device by
# the CA Inventory Manager app.

# Exits if this script is not executed as root
if [ "$EUID" -ne 0 ]; then 
        echo "Please run as root!"
        exit
fi

username=$SUDO_USER

# Task 1 - uninstalls launchd set up

# Checks if the launchd job "com.CAInventoryManager.plist" exists;
# removes the job from launchd if it exists
LABEL=com.CAInventoryManager.plist
if sudo -u "${username}" launchctl list | grep -q "$LABEL"; then
        sudo -u "${username}" launchctl remove "$LABEL"
        echo "Launchd job $LABEL was removed"
fi

# Checks if the /Library/LaunchAgents/com.CAInventoryManager.plist file exists;
# removes the file if it exists
FILE=/Library/LaunchAgents/com.CAInventoryManager.plist
if [ -f "$FILE" ]; then
        rm "$FILE"
        echo "$FILE was removed"
fi

# Checks if the /Users/Shared/CA directory exists;
# removes the directory if it exists
DIRECTORY=/Users/Shared/CA
if [ -d "$DIRECTORY" ]; then
        rm -rf "$DIRECTORY"
        echo "$DIRECTORY application files were removed"
fi

# Task 2 - TODO remove/prompt to remove newly created user (?)

echo "Done!"
exit