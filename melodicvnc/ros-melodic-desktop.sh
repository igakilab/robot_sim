#!/bin/bash
TARGET_ROS="melodic"
INSTALL_TYPE="ros-base"
if [ $# -ne 0 ]; then
  INSTALL_TYPE="${1}"
fi
echo "Start install ros-${TARGET_ROS}"
sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu bionic main" > /etc/apt/sources.list.d/ros-melodic.list'
curl -sSL 'http://keyserver.ubuntu.com/pks/lookup?op=get&search=0xC1CF6E31E6BADE8868B172B4F42ED6FBAB17C654' | sudo apt-key add -

sudo apt-get update -q
sudo apt-get install -y ros-${TARGET_ROS}-${INSTALL_TYPE}
sudo apt-get install -y python-rosdep python-rosinstall python-rosinstall-generator python-wstool build-essential python-catkin-tools

ls /etc/ros/rosdep/sources.list.d/20-default.list > /dev/null 2>&1 && sudo rm /etc/ros/rosdep/sources.list.d/20-default.list
sudo rosdep init 
rosdep update

grep -F "source /opt/ros/${ROS_DISTRO}/setup.bash" ~/.bashrc ||
echo "source /opt/ros/${ROS_DISTRO}/setup.bash" >> ~/.bashrc

grep -F `catkin locate --shell-verbs` ~/.bashrc ||
echo "source `catkin locate --shell-verbs`" >> ~/.bashrc

grep -F "ROS_IP" ~/.bashrc ||
echo "export ROS_IP=127.0.0.1" >> ~/.bashrc

grep -F "ROS_MASTER_URI" ~/.bashrc ||
echo "export ROS_MASTER_URI=http://\$ROS_IP:11311" >> ~/.bashrc
