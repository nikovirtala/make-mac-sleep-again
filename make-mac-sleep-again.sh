#!/bin/bash

echo 'This script will modify MacOS power management settings.'
echo ''
echo 'Enter your password when prompted.'
echo ''

# Disable Power Nap
sudo pmset -a powernap 0

# Disable Wake for Wi-Fi network access
sudo pmset -a womp 0

# Enable Do Not Disturb when display is sleeping

_PLIST=$(ls -1 ~/Library/Preferences/ByHost/com.apple.notificationcenterui*)
grep "dndEnabledDisplaySleep" ${_PLIST}
if [[ $? -ne 0 ]]; then
  /usr/libexec/PlistBuddy -c "Add :dndEnabledDisplaySleep bool true" ${_PLIST}
else
  /usr/libexec/PlistBuddy -c "Set :dndEnabledDisplaySleep bool true" ${_PLIST}
fi

# Disable Darkwake
sudo nvram boot-args="darkwake=0"

echo 'Reboot your computer to make the settings active.'
echo ''
