#!/bin/bash

# Update apt registry.
sudo apt-get update

# Pass grub.
sudo apt-mark hold package grub-pc grub-pc-bin grub2-common grub-common

# Upgrade packages.
sudo apt-get upgrade -y