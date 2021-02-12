FROM dorowu/ubuntu-desktop-lxde-vnc:bionic
LABEL maintainer="IGK"

ENV DEBIAN_FRONTEND noninteractive

RUN echo "Set disable_coredump false" >> /etc/sudo.conf
RUN sed -i 's@archive.ubuntu.com@ftp.jaist.ac.jp/pub/Linux@g' /etc/apt/sources.list \
    && apt-get update -yq \
    && apt-get install -y --no-install-recommends \
    git locales vim sudo bash-completion tzdata wget zip unzip rsync \
    iputils-ping net-tools x11-apps \
    && apt-get -yq clean \
    && rm -rf /var/lib/apt/lists/*

RUN locale-gen ja_JP.UTF-8 && useradd --create-home --home-dir /home/ubuntu --shell /bin/bash --user-group --groups adm,sudo ubuntu \
    && echo ubuntu:ubuntu | chpasswd \
    && echo "ubuntu ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER ubuntu
WORKDIR /home/ubuntu/setup_robot_programming

## ros-melodic setup

COPY ./ros-melodic-desktop.sh /home/ubuntu/setup_robot_programming/ros-melodic-desktop.sh
RUN sudo chmod +x ~/setup_robot_programming/ros-melodic-desktop.sh \
    && bash ~/setup_robot_programming/ros-melodic-desktop.sh \
    && sudo rm -rf /var/lib/apt/lists/*

##############################

#Basic Package
RUN sudo apt-get update -y && sudo apt-get upgrade -y
RUN sudo apt-get install -y --no-install-recommends curl python3-pip python3-setuptools
#sudo apt-get install -y --no-install-recommends openssh-server x11-xserver-utils dbus-x11

#Python Packages
RUN sudo apt-get install -y --no-install-recommends python-tk
#RUN sudo /usr/bin/python3 -m pip install pylint -U \
#	&& sudo /usr/bin/python3 -m pip install autopep8 -U \
#	&& sudo /usr/bin/python3 -m pip install autoflake -U
#	&& sudo /usr/bin/python2 -m pip install pylint -U \
#	&& sudo /usr/bin/python2 -m pip install autopep8 -U \
#	&& sudo /usr/bin/python2 -m pip install autoflake -U \

RUN  sudo /usr/bin/python2 -m pip install pylint -U \
	&& sudo /usr/bin/python2 -m pip install autopep8 -U \
	&& sudo /usr/bin/python2 -m pip install autoflake -U \

#ros Packages
RUN sudo apt-get install -y --no-install-recommends ros-melodic-cv-camera \
	&& sudo apt-get install -y --no-install-recommends ros-melodic-image-transport \
	&& sudo apt-get install -y --no-install-recommends ros-melodic-image-transport-plugins \
	&& sudo apt-get install -y --no-install-recommends ros-melodic-joint-state-publisher-gui \
	&& sudo apt-get install -y --no-install-recommends ros-melodic-joy \
	&& sudo apt-get install -y --no-install-recommends ros-melodic-laser-filters \
	&& sudo apt-get install -y --no-install-recommends ros-melodic-laser-pipeline \
	&& sudo apt-get install -y --no-install-recommends ros-melodic-map-server \
	&& sudo apt-get install -y --no-install-recommends ros-melodic-mouse-teleop \
	&& sudo apt-get install -y --no-install-recommends ros-melodic-navigation \
	&& sudo apt-get install -y --no-install-recommends ros-melodic-robot-state-publisher \
	&& sudo apt-get install -y --no-install-recommends ros-melodic-rosbash \
	&& sudo apt-get install -y --no-install-recommends ros-melodic-rviz \
	&& sudo apt-get install -y --no-install-recommends ros-melodic-slam-gmapping \
	&& sudo apt-get install -y --no-install-recommends ros-melodic-stage-ros \
	&& sudo apt-get install -y --no-install-recommends ros-melodic-rosbridge-suite \
	&& sudo apt-get install -y --no-install-recommends ros-melodic-teleop-twist-joy \
	&& sudo apt-get install -y --no-install-recommends ros-melodic-teleop-twist-keyboard \
	&& sudo apt-get install -y --no-install-recommends ros-melodic-xacro

#Clean
RUN sudo apt-get -yq clean \
    && sudo rm -rf /var/lib/apt/lists/*

COPY ./install_sigverse.sh /home/ubuntu/setup_robot_programming/install_sigverse.sh
RUN sudo chmod +x ~/setup_robot_programming/install_sigverse.sh && bash ~/setup_robot_programming/install_sigverse.sh

RUN sudo chown -R ubuntu:ubuntu /home/ubuntu/setup_robot_programming/
RUN git clone https://github.com/SIGVerse/sigverse_ros_package.git

#RUN sudo apt-get install -y openssh-server
#RUN sudo mkdir -p /var/run/sshd
#COPY ssh.conf /etc/supervisor/conf.d/ssh.conf

# Override entrypoint file
#USER root
RUN sudo apt-get install -y gosu
COPY ./startup.sh /startup.sh
RUN sudo chmod u+x /startup.sh
COPY ./lxterminal.desktop /home/ubuntu/Desktop/lxterminal.desktop

#WORKDIR /home/ubuntu/setup_robot_programming


#ENV LANG ja_JP.UTF-8
#ENV LIBGL_ALWAYS_INDIRECT=0
#ENV DISPLAY host.docker.internal:0.0

#WORKDIR /home/ubuntu

#ENTRYPOINT [ "/home/ubuntu/setup_robot_programming/entrypoint.sh" ]

#Reference
# Timezone https://qiita.com/rururu_kenken/items/972314402d588e073d40
# https://github.com/KMiyawaki/setup_robot_programming
# OpenGL https://b.ueda.tech/?post=20190802
# https://github.com/Tiryoh/docker-ros-desktop-vnc/blob/master/noetic/Dockerfile
# sudo.conf https://qiita.com/tukiyo3/items/3642a99bd971fa829246
# https://github.com/fcwu/docker-ubuntu-vnc-desktop