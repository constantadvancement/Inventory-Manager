#!/usr/bin/env bash

# Path variable is provided by the Launcher app
path="$1/.."

# Prompts the user for their admin password
password="$(osascript -e 'Tell application "System Events" to display dialog "CA Inventory Manager Launcher\n\nEnter your password to continue as an administrator." default answer "" with hidden answer' -e 'text returned of result' 2>/dev/null)"

# Exits with 0 if no password was provided or the user selected "Cancel"
if [ -z "$password" ]; then
    echo "Error: no password was provided or user exited."
    exit 0
fi

# Runs the Inventory Manager app with root access
result="$(echo "$password" | sudo -S ${path}/InventoryManager.app/Contents/MacOS/InventoryManager)"

# Exits with the error code from the previous command
retVal=$?
if [ $retVal -ne 0 ]; then
    echo "Error: incorrect password or an unexpected exit occurred."
else
    echo "Success!"
fi
exit $retVal