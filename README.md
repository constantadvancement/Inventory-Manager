# CA Inventory Manager

Last updated on 12/08/20

## Getting Started

To setup a device within the CA Inventory Management System perform the following three steps.

First, download this entire project directory. Then, execute the Launcher app. Finally, follow and complete all of the setup instructions. Done.

Optionally, after setup has been completed you may choose to delete this downloaded project directory as it is no longer needed.

## CAInventoryManager.app

The main CA Inventory Manager app. The app can launch in one of two modes, "setup" mode or "background" mode. 

In "setup" mode the user will be presented with a user interface which will be used to complete three initial setup tasks. These tasks appear in the following order: provisioning device system information, granting location service authorization, and finally creating a new admin user. Once each task is complete all relevant information will be submitted to the CA Inventory Manager web server. At this point, setup is complete and the device should be restarted in order for the CA Inventory Tracker to automatically begin in "background" mode.

In "background" mode the app will have no user interface components and instead serves only to update this devices location on the CA Inventory Manager web server within a scheduled time interval. If the location service authorization status changes at any pont this will be reported to the CA Inventory Manager web server. 

## Launcher.app

Automator app used to launch the CA Inventory Manager app as an administrator during the initial setup process.

## app-iOS 

Contains all files for the iOS CA Inventory Manager interface app.

## app-macOS

Contains all files for the macOS CA Inventory Manager setup/background app.

## Server

Contains all files for the CA Inventory Manager web server.

## Scripts

### uninstaller.bash

To remove changes made to this device by the CA Inventory Manager app, run the uninstaller.bash script. This can be done by executing `sudo bash scripts/uninstaller.bash` from this project's root directory. You will be prompted to enter your password.

The uninstaller will perform the following two tasks:
1. Removes the CA Inventory Manager launchd job and all of its supporting files/directories that enable it. This launchd job allows the CA Inventory Manager app to periodically ping this device for its location. Once removed this will no longer occur.
2. Permanently deletes the specified user. This should be the user created by the CA Inventory Manager app. Be careful not to delete the wrong user. This step can also be performed manually by navigating to System Preferences > Users & Groups.

Note: the uninstaller must be executed using `sudo` in order to work.

### createUser.bash 

A standalone script used to create an admin user. This script takes three arguments, the new admin user's username, full name, and password. 

### launcher.bash

Helper script used by the Launcher app in order to run the CA Inventory Manager app as an administrator. This script should never be executed manually.
