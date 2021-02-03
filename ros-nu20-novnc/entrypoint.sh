#!/bin/bash -e

sudo chown -R ubuntu:ubuntu /catkin_ws

#ln -sfn /home/developer/.vscode /workspace/.vscode

ln -sfn /catkin_ws /home/ubuntu/catkin_ws

# init workspace
TARGET_ROS="noetic"
echo "**Making workspace. Target ros-${TARGET_ROS}**"
ROS_SETUP="/opt/ros/${TARGET_ROS}/setup.bash"
echo "source ${ROS_SETUP}" >> ~/.bashrc

source /opt/ros/${TARGET_ROS}/setup.bash

mkdir -p /catkin_ws/src && cd /catkin_ws/src && catkin_init_workspace || true

cd /home/ubuntu/setup_robot_programming/sigverse_ros_package && git pull origin master && rsync -av  /home/ubuntu/setup_robot_programming/sigverse_ros_package/ /home/ubuntu/catkin_ws/src/sigverse_ros_package/ && cd /home/ubuntu/catkin_ws/ && catkin_make

WS_SETUP="/catkin_ws/devel/setup.bash"
echo "source ~${WS_SETUP}" >> ~/.bashrc

exec "$@"
#rviz &