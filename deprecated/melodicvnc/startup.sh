#!/bin/bash

if [ -n "$VNC_PASSWORD" ]; then
    echo -n "$VNC_PASSWORD" > /.password1
    sudo gosu root x11vnc -storepasswd $(cat /.password1) /.password2
    sudo gosu root chmod 400 /.password*
    sudo gosu root sed -i 's/^command=x11vnc.*/& -rfbauth \/.password2/' /etc/supervisor/conf.d/supervisord.conf
    sudo gosu root export VNC_PASSWORD=
fi

if [ -n "$X11VNC_ARGS" ]; then
    sudo gosu root sed -i "s/^command=x11vnc.*/& ${X11VNC_ARGS}/" /etc/supervisor/conf.d/supervisord.conf
fi

if [ -n "$OPENBOX_ARGS" ]; then
    sudo gosu root sed -i "s#^command=/usr/bin/openbox\$#& ${OPENBOX_ARGS}#" /etc/supervisor/conf.d/supervisord.conf
fi

if [ -n "$RESOLUTION" ]; then
    sudo gosu root sed -i "s/1024x768/$RESOLUTION/" /usr/local/bin/xvfb.sh
fi

USER=${USER:-root}
HOME=/root
if [ "$USER" != "root" ]; then
    echo "* enable custom user: $USER"
    sudo gosu root useradd --create-home --shell /bin/bash --user-group --groups adm,sudo $USER
    if [ -z "$PASSWORD" ]; then
        echo "  set default password to \"ubuntu\""
        PASSWORD=ubuntu
    fi
    HOME=/home/$USER
    echo "$USER:$PASSWORD" | sudo gosu root chpasswd
    sudo gosu root cp -r /root/{.config,.gtkrc-2.0,.asoundrc} ${HOME}
    sudo gosu root chown -R $USER:$USER ${HOME}
    [ -d "/dev/snd" ] && sudo gosu root chgrp -R adm /dev/snd
fi
sudo gosu root sed -i -e "s|%USER%|$USER|" -e "s|%HOME%|$HOME|" /etc/supervisor/conf.d/supervisord.conf

# home folder
if [ ! -x "$HOME/.config/pcmanfm/LXDE/" ]; then
    mkdir -p $HOME/.config/pcmanfm/LXDE/
    sudo gosu root ln -sf /usr/local/share/doro-lxde-wallpapers/desktop-items-0.conf $HOME/.config/pcmanfm/LXDE/
    sudo gosu root chown -R $USER:$USER $HOME
fi

# nginx workers
sudo gosu root sed -i 's|worker_processes .*|worker_processes 1;|' /etc/nginx/nginx.conf

# nginx ssl
if [ -n "$SSL_PORT" ] && [ -e "/etc/nginx/ssl/nginx.key" ]; then
    echo "* enable SSL"
	sudo gosu root sed -i 's|#_SSL_PORT_#\(.*\)443\(.*\)|\1'$SSL_PORT'\2|' /etc/nginx/sites-enabled/default
	sudo gosu root sed -i 's|#_SSL_PORT_#||' /etc/nginx/sites-enabled/default
fi

# nginx http base authentication
if [ -n "$HTTP_PASSWORD" ]; then
    echo "* enable HTTP base authentication"
    sudo gosu root htpasswd -bc /etc/nginx/.htpasswd $USER $HTTP_PASSWORD
	sudo gosu root sed -i 's|#_HTTP_PASSWORD_#||' /etc/nginx/sites-enabled/default
fi

# dynamic prefix path renaming
if [ -n "$RELATIVE_URL_ROOT" ]; then
    echo "* enable RELATIVE_URL_ROOT: $RELATIVE_URL_ROOT"
	sudo gosu root sed -i 's|#_RELATIVE_URL_ROOT_||' /etc/nginx/sites-enabled/default
	sudo gosu root sed -i 's|_RELATIVE_URL_ROOT_|'$RELATIVE_URL_ROOT'|' /etc/nginx/sites-enabled/default
fi

# clearup
PASSWORD=
HTTP_PASSWORD=

# init ros workspace

#su - ubuntu

#ln -sfn /home/developer/.vscode /workspace/.vscode

sudo gosu root ln -sfn /catkin_ws /home/ubuntu/catkin_ws

# init workspace
TARGET_ROS="melodic"
echo "**Making workspace. Target ros-${TARGET_ROS}**"
#ROS_SETUP="/opt/ros/${TARGET_ROS}/setup.bash"
#echo "source ${ROS_SETUP}" >> ~/.bashrc

source /opt/ros/${TARGET_ROS}/setup.bash

sudo chown ubuntu:ubuntu -R /catkin_ws

mkdir -p /catkin_ws/src && cd /catkin_ws/src && catkin_init_workspace || true

cd /home/ubuntu/setup_robot_programming/sigverse_ros_package && git pull origin master && rsync -av  /home/ubuntu/setup_robot_programming/sigverse_ros_package/ /home/ubuntu/catkin_ws/src/sigverse_ros_package/ --exclude '.git/' && cd /home/ubuntu/catkin_ws/ && catkin_make

WS_SETUP="/catkin_ws/devel/setup.bash"
echo "source ~${WS_SETUP}" >> ~/.bashrc

sudo chown ubuntu:ubuntu -R /catkin_ws


sudo gosu root /bin/tini -- supervisord -n -c /etc/supervisor/supervisord.conf