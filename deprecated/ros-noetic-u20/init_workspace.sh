#!/bin/bash
TARGET_ROS="noetic"
echo "**Making workspace. Target ros-${TARGET_ROS}**"
ROS_SETUP="/opt/ros/${TARGET_ROS}/setup.bash"
echo "source ${ROS_SETUP}" >> ~/.bashrc

source ${ROS_SETUP}
mkdir -p ~/catkin_ws/src
cd ~/catkin_ws/src/
catkin_init_workspace
cd ..
catkin_make
cd
WS_SETUP="/catkin_ws/devel/setup.bash"
echo "source ~${WS_SETUP}" >> ~/.bashrc
