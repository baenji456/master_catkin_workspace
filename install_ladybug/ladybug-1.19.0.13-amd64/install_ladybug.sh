#!/bin/bash

set -o errexit

confirm="Y"


if ! ( [ "$confirm" = "y" ] || [ "$confirm" = "Y" ] || [ "$confirm" = "yes" ] || [ "$confirm" = "Yes" ] || [ "$confirm" = "" ] )
then
    exit 0
fi

echo

set +o errexit
EXISTING_VERSION=$(dpkg -s ladybug 2> /dev/null | grep '^Version:' | sed 's/^.*: //')
set -o errexit

if [ ! -z "$EXISTING_VERSION" ]; then
    echo "A previous installation of Ladybug has been detected on this machine (Version: $EXISTING_VERSION). Please consider uninstalling the previous version of Ladybug before continuing with this installation." >&2
    echo "Would you like to continue with this installation?"
    echo -n "$MY_YESNO_PROMPT"
    read confirm
    if ! ( [ "$confirm" = "y" ] || [ "$confirm" = "Y" ] || [ "$confirm" = "yes" ] || [ "$confirm" = "Yes" ] || [ "$confirm" = "" ] )
    then
        exit 0
    fi
fi

echo "Installing Ladybug packages..."

yes | sudo dpkg -i /home/benni/catkin_ws/install_ladybug/ladybug-1.19.0.13-amd64/ladybug*.deb

echo
echo "Would you like to add a udev rule?"
echo "  Rules will be created to add the 1394 cards and USB devices to a group called flirimaging."
echo "  Please note that this will change the permissions for all IEEE1394/USB devices"
echo "  including hard drives and web cams. It will allow members of the flirimaging group"
echo "  to read and modify data on any IEEE1394/USB device."

if [ "$confirm" = "y" ] || [ "$confirm" = "Y" ] || [ "$confirm" = "yes" ] || [ "$confirm" = "Yes" ] || [ "$confirm" = "" ]
then
    echo "Launching udev configuration script..."
    sudo sh /home/benni/catkin_ws/install_ladybug/ladybug-1.19.0.13-amd64/configure_ladybug.sh
fi

echo
echo "Installation complete."

echo "Thank you for installing the Ladybug SDK."
exit 0

