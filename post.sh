#!/bin/bash

# Clear apt cache.
sudo apt-get clean

# Cleanup disk.
sudo dd if=/dev/zero of=/EMPTY bs=1M
sudo rm -f /EMPTY

# Clear bash history.
cat /dev/null > ~/.bash_history && history -c && exit