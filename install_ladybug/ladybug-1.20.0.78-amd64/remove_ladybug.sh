#!/bin/bash

MY_YESNO_PROMPT='[Y/n] $ '

echo "This is a script to assist with the removal of the Ladybug SDK."
echo "Would you like to continue and remove all the Ladybug packages?"
echo -n "$MY_YESNO_PROMPT"
read confirm
if ! ( [ "$confirm" = "y" ] || [ "$confirm" = "Y" ] || [ "$confirm" = "yes" ] || [ "$confirm" = "Yes" ] || [ "$confirm" = "" ] )
then
    exit 0
fi

echo
echo "Removing Ladybug packages..."

sudo dpkg -P ladybug

echo "Removing udev rules file..."

if [ -e "/etc/udev/rules.d/40-pgr-ladybug.rules" ]
then
    sudo rm /etc/udev/rules.d/40-pgr-ladybug.rules
fi

echo "Uninstallation complete."
exit 0
