#!/bin/bash

# Clear apt cache.
apt-get clean

# Cleanup disk.
#dd if=/dev/zero of=/EMPTY bs=1M
#rm -f /EMPTY

# Clear bash history.
cat /dev/null > ~/.bash_history && history -c && exit