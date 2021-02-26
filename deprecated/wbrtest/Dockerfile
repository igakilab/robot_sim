FROM ros:melodic-ros-base
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

RUN set -ex; \
    apt-get update; \
    apt-get install -y \
      fluxbox \
      supervisor \
      x11vnc \
      xterm \
      xvfb

RUN mkdir -p /opt/noVNC/utils/websockify && \
    wget -qO- "http://github.com/novnc/noVNC/tarball/master" | tar -zx --strip-components=1 -C /opt/noVNC && \
    wget -qO- "https://github.com/novnc/websockify/tarball/master" | tar -zx --strip-components=1 -C /opt/noVNC/utils/websockify && \
    ln -s /opt/noVNC/vnc.html /opt/noVNC/index.html

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
RUN sudo apt-get install -y gosu

# tini to fix subreap
ARG TINI_VERSION=v0.19.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /bin/tini
RUN sudo chmod +x /bin/tini

#USER ubuntu

COPY ./app/ /app
CMD ["/app/entrypoint.sh"]
EXPOSE 8080
