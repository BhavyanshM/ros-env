#! /bin/bash

apt-get update
apt-get install -y python-rosinstall python-rosinstall-generator python-wstool build-essential
apt-get install -y python-catkin-tools
apt-get install -y python-wstool python-pip
pip install catkin_pkg


# Setup catkin workspace
mkdir -p ~/catkin_ws/src
cd ~/catkin_ws/
catkin init
# Add workspace to bashrc.
echo 'source ~/catkin_ws/devel/setup.bash' >> ~/.bashrc
cd src
wstool init
# Install FlightGoggles nodes and deps from rosinstall file
wstool merge https://raw.githubusercontent.com/mit-fast/FlightGoggles/master/flightgoggles.rosinstall
wstool update
cd ../
# Install required libraries.
rosdep install --from-paths src --ignore-src --rosdistro melodic -y
# Install external libraries for flightgoggles_ros_bridge
apt install -y libzmqpp-dev libeigen3-dev
# Install dependencies for flightgoggles renderer
apt install -y libvulkan1 mesa-vulkan-drivers vulkan-utils

apt-get install -y libsdl-image1.2-dev libsdl-dev

# Build nodes
catkin build
# Refresh workspace
source ~/.bashrc
