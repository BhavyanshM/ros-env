#! /bin/bash

apt-get update
apt-get install -y ros-kinetic-rtabmap-ros dbus-x11 libcanberra-gtk3-module
cd ../../
git clone https://github.com/introlab/rtabmap_ros.git
cd rtabmap_ros
