FROM ros:noetic-ros-base

ENV DEBIAN_FRONTEND noninteractive

RUN sed -i 's@archive.ubuntu.com@ftp.jaist.ac.jp/pub/Linux@g' /etc/apt/sources.list \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
    git \
    locales \
    wget \
    && apt-get -y clean \
    && rm -rf /var/lib/apt/lists/*

RUN locale-gen ja_JP.UTF-8 && useradd --create-home --home-dir /home/ubuntu --shell /bin/bash --user-group --groups adm,sudo ubuntu && \
    echo ubuntu:ubuntu | chpasswd && \
    echo "ubuntu ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
USER ubuntu
RUN sudo apt update
RUN sudo apt-get install -y iputils-ping net-tools x11-apps

WORKDIR /home/ubuntu/setup_robot_programming

#Basic Package
RUN sudo apt-get update -y && sudo apt-get upgrade -y
RUN sudo apt-get install -y --no-install-recommends curl python3-pip python3-setuptools zip unzip
#sudo apt-get install -y --no-install-recommends openssh-server x11-xserver-utils dbus-x11

#Python Packages
RUN sudo apt-get install -y --no-install-recommends python-tk
RUN sudo /usr/bin/python3 -m pip install pylint -U \
	&& sudo /usr/bin/python3 -m pip install autopep8 -U \
	&& sudo /usr/bin/python3 -m pip install autoflake -U
#	&& sudo /usr/bin/python2 -m pip install pylint -U \
#	&& sudo /usr/bin/python2 -m pip install autopep8 -U \
#	&& sudo /usr/bin/python2 -m pip install autoflake -U \

#ros Packages
RUN sudo apt-get install -y --no-install-recommends ros-noetic-cv-camera \
	&& sudo apt-get install -y --no-install-recommends ros-noetic-image-transport \
	&& sudo apt-get install -y --no-install-recommends ros-noetic-image-transport-plugins \
	&& sudo apt-get install -y --no-install-recommends ros-noetic-joint-state-publisher-gui \
	&& sudo apt-get install -y --no-install-recommends ros-noetic-joy \
	&& sudo apt-get install -y --no-install-recommends ros-noetic-laser-filters \
	&& sudo apt-get install -y --no-install-recommends ros-noetic-laser-pipeline \
	&& sudo apt-get install -y --no-install-recommends ros-noetic-map-server \
	&& sudo apt-get install -y --no-install-recommends ros-noetic-mouse-teleop \
	&& sudo apt-get install -y --no-install-recommends ros-noetic-navigation \
	&& sudo apt-get install -y --no-install-recommends ros-noetic-robot-state-publisher \
	&& sudo apt-get install -y --no-install-recommends ros-noetic-rosbash \
	&& sudo apt-get install -y --no-install-recommends ros-noetic-rviz \
	&& sudo apt-get install -y --no-install-recommends ros-noetic-slam-gmapping \
	&& sudo apt-get install -y --no-install-recommends ros-noetic-stage-ros \
	&& sudo apt-get install -y --no-install-recommends ros-noetic-rosbridge-suite \
	&& sudo apt-get install -y --no-install-recommends ros-noetic-teleop-twist-joy \
	&& sudo apt-get install -y --no-install-recommends ros-noetic-teleop-twist-keyboard \
	&& sudo apt-get install -y --no-install-recommends ros-noetic-xacro

#Clean
RUN sudo apt-get -y clean \
    && sudo rm -rf /var/lib/apt/lists/*

#init ws
#COPY ./init_workspace.sh /home/ubuntu/setup_robot_programming/init_workspace.sh
#RUN sudo chmod +x ~/setup_robot_programming/init_workspace.sh && bash ~/setup_robot_programming/init_workspace.sh

COPY ./install_sigverse.sh /home/ubuntu/setup_robot_programming/install_sigverse.sh
RUN sudo chmod +x ~/setup_robot_programming/install_sigverse.sh && bash ~/setup_robot_programming/install_sigverse.sh

RUN sudo chown -R ubuntu:ubuntu /home/ubuntu/setup_robot_programming
RUN git clone https://github.com/SIGVerse/sigverse_ros_package.git

COPY ./entrypoint.sh /home/ubuntu/setup_robot_programming/entrypoint.sh
RUN sudo chmod +x ~/setup_robot_programming/entrypoint.sh

#ENV LANG ja_JP.UTF-8
#ENV LIBGL_ALWAYS_INDIRECT=0
ENV DISPLAY host.docker.internal:0.0

RUN sudo apt-get install -y rsync
WORKDIR /home/ubuntu

#ENTRYPOINT [ "/home/ubuntu/setup_robot_programming/entrypoint.sh" ]

#Reference
# Timezone https://qiita.com/rururu_kenken/items/972314402d588e073d40
# https://github.com/KMiyawaki/setup_robot_programming
# OpenGL https://b.ueda.tech/?post=20190802