# CA Inventory Manager

Last updated on 11/18/20

## InventoryManager.app

TODO

## Launcher.app

Automator app used to launch the CA Inventory Manager app as an administrator during the initial set up process.

## App

TODO

## Server

TODO

## Scripts

### uninstaller.bash

To remove changes made to this device by the CA Inventory Manager app, run the uninstaller.bash script. This can be done by executing `sudo bash scripts/uninstaller.bash` from this project's root directory. You will be prompted to enter your password.

The uninstaller will perform the following two tasks:
1. Removes the CA Inventory Manager launchd job and all of its supporting files/directories that enable it. This launchd job allows the CA Inventory Manager app to periodically ping this device for its location. Once removed this will no longer occur.
2. TODO -- remove/prompt to remove the newly created user (?)

Note: the uninstaller must be executed using sudo in order to work.

### launcher.bash

Helper script used by the Launcher app in order to run the CA Inventory Manager app as an administrator.

This script should not be executed from outside of the Launcher app.