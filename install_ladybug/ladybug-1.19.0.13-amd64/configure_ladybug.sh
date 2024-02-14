#!/bin/bash

set -o errexit

grpname="flirimaging"

if [ "$(id -u)" = "0" ]
then
    echo
    echo "This script will assist users in configuring their udev rules to allow"
    echo "access to IEEE1394/USB devices. The script will create a udev rule which will"
    echo "add FLIR IEEE1394/USB devices to a group called $grpname. The user may also"
    echo "choose to restart the udev daemon. All of this can be done manually as well."
    echo
else
    echo
    echo "This script needs to be run as root, e.g.:"
    echo "sudo configure_ladybug.sh"
    echo
    exit 0
fi

confirm="y"
usrname="$USER"

echo "Adding new members to usergroup $grpname..." 
while :
do
    # Show current members of the user group
    users=$(grep -E '^'$grpname':' /etc/group |sed -e 's/^.*://' |sed -e 's/, */, /g')
    if [ -z "$users" ]
    then 
        echo "Usergroup $grpname is empty"
    else
        echo "Current members of $grpname group: $users"
    fi

    echo "To add a new member please enter username (or hit Enter to continue):"

    if [ "$usrname" = "" ]
    then
        break
    else
        # Check if user name exists
        if (getent passwd $usrname > /dev/null)
        then
            # Get confirmation that the username is ok 
            echo "Adding user $usrname to group $grpname group. Is this OK?"
            if [ "$confirm" = "y" ] || [ "$confirm" = "Y" ] || [ "$confirm" = "yes" ] || [ "$confirm" = "Yes" ] || [ "$confirm" = "" ]
            then
                # Create user group (if not exists) and add user to it
                groupadd -f $grpname
                usermod -a -G $grpname $usrname
                echo "Added user $usrname"
                usrname=""
            fi
        else
            echo "User "\""$usrname"\"" does not exist"
        fi
    fi
done

# Create udev rule
UdevFile="/etc/udev/rules.d/40-pgr-ladybug.rules";
echo
echo "Writing the udev rules file...";
# for Ladybug products prior to Ladybug6
echo "ATTRS{idVendor}==\"1e10\", ATTRS{idProduct}==\"3800\", MODE=\"0664\", GROUP=\"$grpname\"" 1>$UdevFile
# for Ladybug6
echo "ATTRS{idVendor}==\"1e10\", ATTRS{idProduct}==\"3801\", MODE=\"0664\", GROUP=\"$grpname\"" 1>>$UdevFile
# for Ladybug6A
echo "ATTRS{idVendor}==\"1e10\", ATTRS{idProduct}==\"3802\", MODE=\"0664\", GROUP=\"$grpname\"" 1>>$UdevFile
echo "KERNEL==\"raw1394\", MODE=\"0664\", GROUP=\"$grpname\"" 1>>$UdevFile
echo "KERNEL==\"video1394*\", MODE=\"0664\", GROUP=\"$grpname\"" 1>>$UdevFile
echo "SUBSYSTEM==\"firewire\", GROUP=\"$grpname\"" 1>>$UdevFile

echo "Do you want to restart the udev daemon?"
confirm="y"
if [ "$confirm" = "y" ] || [ "$confirm" = "Y" ] || [ "$confirm" = "yes" ] || [ "$confirm" = "Yes" ] || [ "$confirm" = "" ]
then
    if which invoke-rc.d >/dev/null 2>&1; then
        invoke-rc.d udev restart
    else
        /etc/init.d/udev restart
    fi
else
    echo "Udev was not restarted.  Please reboot the computer for the rules to take effect."
    exit 0
fi

echo "Configuration complete."
echo "A reboot may be required on some systems for changes to take effect."
exit 0

