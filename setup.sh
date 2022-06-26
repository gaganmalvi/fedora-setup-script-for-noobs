#!/bin/bash

#
# Set up a Fedora environment for an end user, including proprietary codecs, Google Chrome, and VS Code.
#
# This script is intended to be run on a fresh Fedora installation, as root.
#

# Update system
dnf upgrade

echo "Enabling RPMFusion..."
# Enable RPMFusion Free
dnf install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm

# Enable RPMFusion Nonfree
dnf install https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

# Install multimedia libraries
echo "Installing multimedia libraries..."
dnf install gstreamer1-plugins-{bad-\*,good-\*,base} gstreamer1-plugin-openh264 gstreamer1-libav --exclude=gstreamer1-plugins-bad-free-devel

echo "Installing LAME..."
dnf install lame\* --exclude=lame-devel

echo "Upgrading group..."
dnf group upgrade --with-optional Multimedia

# Install Fedora Workstation Repositories
echo "Installing Fedora Workstation Repositories..."
dnf install fedora-workstation-repositories

# Enable Google Chrome Repo
echo "Enabling Google Chrome Repo..."
dnf config-manager --set-enabled google-chrome

# Install Chrome
echo "Installing Google Chrome..."
dnf install google-chrome-stable

# Install VS Code
echo "Installing VS Code..."
rpm --import https://packages.microsoft.com/keys/microsoft.asc
sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
dnf check-update
dnf install code

# Install VLC
echo "Installing VLC..."
dnf install vlc

# Add flatpak repo
echo "Adding flatpak repo..."
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# Install Gnome tweaks
echo "Installing Gnome tweaks..."
dnf install gnome-tweaks gnome-extensions-app

