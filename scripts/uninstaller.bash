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

# Prompt to remove launchd files
removeLaunchd=false
while true; do
    read -p "Do you wish to remove the CA Inventory Manager launchd files? " yn
    case $yn in
        [Yy]* ) removeLaunchd=true; break;;
        [Nn]* ) break;;
        * ) echo "Please answer yes or no.";;
    esac
done

if [ "$removeLaunchd" = true ]; then
        # Checks if the launchd job "com.CAInventoryManager.plist" exists;
        # removes the job from launchd if it exists
        LABEL=com.CAInventoryManager.plist
        if sudo -u "${username}" launchctl list | grep -q "$LABEL"; then
                sudo -u "${username}" launchctl remove "$LABEL"
                echo "Launchd job $LABEL was removed"
        fi

        # Checks if the /Library/LaunchAgents/com.CAInventoryManager.plist file exists;
        # removes the plist file if it exists
        FILE=/Library/LaunchAgents/com.CAInventoryManager.plist
        if [ -f "$FILE" ]; then
                rm "$FILE"
                echo "$FILE was removed"
        fi

        # Checks if the /Users/Shared/CA directory exists;
        # removes the directory and all contained app files if it exists
        DIRECTORY=/Users/Shared/CA
        if [ -d "$DIRECTORY" ]; then
                rm -rf "$DIRECTORY"
                echo "$DIRECTORY application files were removed"
        fi
fi

# Task 2 - remove newly created user

# Prompt to delete the new admin user
deleteUser=false
while true; do
        read -p "Do you wish to delete a user? " yn
        case $yn in
                [Yy]* ) deleteUser=true; break;;
                [Nn]* ) echo "If you wish to delete the user manually, navigate to System Preferences > Users & Groups."; break;;
                * ) echo "Please answer yes or no.";;
        esac
done

if [ "$deleteUser" = true ]; then
        # Prompt for username
        while true; do
                read -p "Please enter the username to delete. " username
                if dscl . list /users | grep -w -q "$username"; then
                        break
                fi
                echo "Invalid username."
        done

        # Prompt for clarification
        while true; do
                read -p "Are you sure you wish to permanently delete $username? " yn
                case $yn in
                        [Yy]* ) break;;
                        [Nn]* ) echo "If you wish to delete the user manually, navigate to System Preferences > Users & Groups."; echo "Uninstaller has finished!"; exit;;
                        * ) echo "Please answer yes or no.";;
                esac
        done

        # Deletes the specified user
        dscl . delete /users/"$username"
        echo "$username was deleted"
fi

echo "Uninstaller has finished!"
exit