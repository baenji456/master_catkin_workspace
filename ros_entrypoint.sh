#!/bin/bash

# source ros noetic
source /opt/ros/noetic/setup.bash

# deactivate frontend to avoid requests during rosdep install
#export DEBIAN_FRONTEND=noninteractive

# install ros dependencies
# not possible in Dockerfile (mount is not available from Dockerfile)
#rosdep install --from-path src --ignore-src -r -y

# Configuring USB-FS
sh -c 'echo 1000 > /sys/module/usbcore/parameters/usbfs_memory_mb'

# build catkin workspace
catkin_make
# source devel/setup.bash

# roslaunch

echo 'container started'
# let container open
tail -F /dev/null