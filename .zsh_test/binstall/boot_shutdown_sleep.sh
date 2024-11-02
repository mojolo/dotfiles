#!/bin/bash

# Fix Gigabyte bios sleep/suspend issues
sudo cp biosWakeupWorkaround.service /etc/systemd/system/
sudo systemctl daemon-reload
sudo systemctl enable biosWakeupWorkaround.service

# Fix error: Process '/usr/bin/unshare -m /usr/bin/snap auto-import --mount=/dev/nvme0n1' failed with exit code 1.
sudo mv "/lib/udev/rules.d/66-snapd-autoimport.rules" "/lib/udev/rules.d/66-snapd-autoimport.rules.OFF"

