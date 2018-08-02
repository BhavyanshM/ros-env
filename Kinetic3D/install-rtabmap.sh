#! /bin/bash

apt-get update
echo "source /opt/ros/kinetic/setup.bash" >> ~/.bashrc
source ~/.bashrc
apt-get install -y ros-kinetic-rtabmap-ros dbus-x11 libcanberra-gtk3-module
apt-get install -y mesa-utils binutils kmod
cd ../../nvidia-driver &&  sh NVIDIA-Linux-x86_64-390.77.run -a -N --ui=none --no-kernel-module && cd -
#cd ../../ && rm -rf rtabmap_ros && git clone https://github.com/introlab/rtabmap_ros.git && cd rtabmap_ros
