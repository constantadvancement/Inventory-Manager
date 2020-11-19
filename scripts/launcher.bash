# Prompts the user for their admin password
password="$(osascript -e 'Tell application "System Events" to display dialog "CA Inventory Manager Launcher\n\nEnter your password to continue as an administrator." default answer "" with hidden answer' -e 'text returned of result' 2>/dev/null)"

# Exits if no password was provided
if [ -z "$password" ]; then
    exit
fi

# Runs the Inventory Manager app with root access
echo "$password" | sudo -S $1/../InventoryManager.app/Contents/MacOS/InventoryManager

# -------------- TODO better error handling for this script --------------