#!/bin/bash

set -o errexit

confirm="y"
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

yes | sudo dpkg -i install_ladybug/ladybug-1.20.0.78-amd64/ladybug*.deb 


if [ "$confirm" = "y" ] || [ "$confirm" = "Y" ] || [ "$confirm" = "yes" ] || [ "$confirm" = "Yes" ] || [ "$confirm" = "" ]
then
    echo "Launching udev configuration script..."
    sudo sh install_ladybug/ladybug-1.20.0.78-amd64/configure_ladybug.sh
fi

echo
echo "Installation complete."

echo "Thank you for installing the Ladybug SDK."
exit 0

