FROM ros:noetic-ros-base

LABEL maintainer="IGK"

ENV DEBIAN_FRONTEND noninteractive

RUN echo "Set disable_coredump false" >> /etc/sudo.conf
RUN sudo apt-get update -y
RUN sudo apt-get install git -y \
	&& cd /root && git clone https://github.com/KMiyawaki/setup_robot_programming.git

WORKDIR /root/setup_robot_programming
RUN ./stop_update.sh
RUN ./install_basic_packages.sh
RUN ./install_python_packages.sh
RUN ./install_chrome.sh

RUN useradd --create-home --home-dir /home/ubuntu --shell /bin/bash --user-group --groups adm,sudo ubuntu \
    && echo ubuntu:ubuntu | chpasswd \
    && echo "ubuntu ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

RUN sudo apt-get install -y gosu

# tini to fix subreap
ARG TINI_VERSION=v0.19.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /bin/tini
RUN sudo chmod +x /bin/tini

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

RUN apt-get update && \
    # Install the required packages for desktop    
    apt-get install -y \
      supervisor \
      xvfb \
      xfce4 \
      x11vnc \
      && \
    # Install utilities(optional).
    apt-get install -y \
      wget \
      curl \
      net-tools \
      vim-tiny \
      xfce4-terminal \
      tzdata rsync wget supervisor
RUN apt-get clean && \
    rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/*

# Install noVNC
RUN mkdir -p /opt/noVNC/utils/websockify && \
    wget -qO- "http://github.com/novnc/noVNC/tarball/master" | tar -zx --strip-components=1 -C /opt/noVNC && \
    wget -qO- "https://github.com/novnc/websockify/tarball/master" | tar -zx --strip-components=1 -C /opt/noVNC/utils/websockify && \
    ln -s /opt/noVNC/vnc.html /opt/noVNC/index.html

ADD ./app /app

USER ubuntu

COPY ./install_sigverse.sh ./install_sigverse.sh
RUN sudo chmod +x ./install_sigverse.sh && bash ./install_sigverse.sh

WORKDIR /home/ubuntu/

#RUN sudo chown -R ubuntu:ubuntu /home/ubuntu/setup_robot_programming/
RUN git clone https://github.com/SIGVerse/sigverse_ros_package.git


ENTRYPOINT ["/app/startup.sh"]